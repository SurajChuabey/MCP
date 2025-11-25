from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

import uvicorn

app = FastAPI()

# Allow Flutter app (Android/iOS/web) to access API
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # You can restrict this to your Flutter device IP if you want
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Dummy category data
category_data = [
    {"catagory": "Food", "value": 35},
    {"catagory": "Travel", "value": 25},
    {"catagory": "Bills", "value": 15},
    {"catagory": "Shopping", "value": 15},
    {"catagory": "Others", "value": 10},
]

@app.get("/catagory")
async def get_catagory():
    """Return dummy expense category data"""
    return category_data

@app.get("/")
async def root():
    """Root endpoint for health check"""
    return {"message": "FastAPI Dummy Expense API is running!"}



class Expense(BaseModel):
    amount: float
    description: str
    category: str
    date: str


@app.post("/expenses")
async def add_expense(expense: Expense):
    print("🔥 New Expense Received:")
    print(expense.model_dump_json())
    return {"status": "received", "data": expense}

# Run server directly if executed as main script
if __name__ == "__main__":
    uvicorn.run("dummyapi:app", host="0.0.0.0", port=5000, reload=True)

