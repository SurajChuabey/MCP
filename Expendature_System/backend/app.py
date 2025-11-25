import uvicorn
from fastapi import FastAPI
from fastmcp import FastMCP
from fastapi.middleware.cors import CORSMiddleware
from app.routes.router import api_router
from app.utils.config_manager import ConfigManager
from app.constants.constants import Constants

app = FastAPI(title="Expendature Backend", version='1.0.0')

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], 
    allow_credentials=True,
    allow_methods=["*"],  
    allow_headers=["*"],
)

app.include_router(router=api_router)


mcp = FastMCP.from_fastapi(
    app=app,
    name="expenditure-backend",
    version="1.0.0",
)

# Start FastMCP runtime
def start_backend():
    mcp.run(
        host=ConfigManager.config(Constants.DEFAULTS, Constants.HOST),
        port=int(ConfigManager.config(Constants.DEFAULTS, Constants.PORT)),
        transport='sse',
    )

if __name__ == "__main__":
    start_backend()