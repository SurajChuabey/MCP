import asyncio
from mcp import ClientSession
from mcp.client.sse import sse_client
from google import genai
from constant import API_KEY

# ----------------------------
# 1️⃣ Initialize Gemini Client
# ----------------------------
def init_gemini_client():
    try:
        client = genai.Client(api_key=API_KEY)
        return client
    except Exception as e:
        print("Error initializing Gemini client:", e)
        return None

# ----------------------------
# 2️⃣ Ask Gemini which tool & arguments to use
# ----------------------------
async def choose_tool_and_args(gemini:genai.Client, prompt, tools):
    """
    Ask Gemini to choose a tool and provide input arguments.
    Returns (tool_name, kwargs)
    """
    
    gemini_prompt = f"""
    You are an assistant. User wants to perform a task: "{prompt}".
    Here are the available MCP tools: {tools}.
    
    Respond in JSON format with:
    {{
        "tool": "<tool_name>",
        "kwargs": {{
            "arg1": "value1",
            ...
        }}
    }}
    Ensure the tool name is exactly one from the list.
    """
    
    response = gemini.models.generate_content(model="gemini-2.5-flash", contents=[gemini_prompt])
    print(f"========================={response}============================")
    
    # Parse Gemini response
    import json
    try:
        # 1. Get the raw response text
        response_text = response.text.strip()
        
        if response_text.startswith("```json"):
            json_start = response_text.find('{')
            json_end = response_text.rfind('}')
            
            if json_start != -1 and json_end != -1:
                json_string = response_text[json_start : json_end + 1]
            else:
                json_string = response_text.replace("```json", "").replace("```", "").strip()
        else:
            json_string = response_text
        
        # 3. Load the cleaned string as JSON
        parsed = json.loads(json_string)

        tool_name = parsed.get("tool")
        kwargs = parsed.get("kwargs", {})
        # print(f"***************************{tools.tools}*****************")
        return tool_name, kwargs

    except Exception as e:
        print("Failed to parse Gemini response:", e)

# ----------------------------
# 3️⃣ Run the tool dynamically
# ----------------------------
async def run_tool_from_prompt(gemini:genai.Client, prompt):
    async with sse_client('http://localhost:8080/sse') as streams:
        async with ClientSession(*streams) as session:
            await session.initialize()
            
            # List all tools
            tools = await session.list_tools()
            # print("Available MCP tools:", tools.tools)
            
            # Gemini decides which tool & arguments
            tool_name, kwargs = await choose_tool_and_args(gemini, prompt, tools)
            print(f"choosen tools and args {tool_name} ===== {kwargs}")
            if not tool_name:
                return
            
            # Call the tool dynamically with kwargs
            response = await session.call_tool(tool_name,kwargs)
            print(f"Response from {tool_name}:", response)

# ----------------------------
# 4️⃣ Main
# ----------------------------
async def main():
    gemini = init_gemini_client()
    if not gemini:
        return
    
    user_prompt = "i want add expense for neeraj for buying bag of worth 2400 yesterday of catagory 3"
    await run_tool_from_prompt(gemini, user_prompt)

if __name__ == "__main__":
    asyncio.run(main())
# 