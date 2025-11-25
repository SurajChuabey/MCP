from pydantic import BaseModel
from datetime import date, datetime
from typing import Optional

# ---------------------------
# Request schemas
# ---------------------------

class ExpenseList(BaseModel):
    user_name: str
    category_id: Optional[int] = None
    min_amount: Optional[float] = None
    max_amount: Optional[float] = None
    start_date: Optional[date] = None
    end_date: Optional[date] = None


class ExpenseAdd(BaseModel):
    user_name: str
    category_id: int
    amount: float
    description: Optional[str] = None
    date: date
    created_at: Optional[datetime] = None  


class ExpenseUpdate(BaseModel):
    id: Optional[int] = None
    user_name: Optional[str] = None
    category_id: Optional[int] = None
    amount: Optional[float] = None
    description: Optional[str] = None
    date: Optional[date]
    created_at: Optional[datetime] = None


class ExpenseDelete(BaseModel):
    id: Optional[int] = None
    user_name:str = None
    category_id:int = None
    expense_date: Optional[date]