from pydantic import BaseModel
from datetime import date
from typing import Optional


class BudgetGet(BaseModel):
    user_name: str                     
    month: date                       
    category_id: Optional[int] = None


class BudgetCreate(BaseModel):
    user_name: str
    month: date
    budget_amount: float
    category_id: int                   
    sub_category: Optional[str] = None


class BudgetUpdate(BaseModel):
    user_name: Optional[str] = None
    month: Optional[date] = None
    budget_amount: Optional[float] = None
    category_id: Optional[int] = None
    sub_category: Optional[str] = None


class BudgetDelete(BaseModel):
    month: date


class BudgetResponse(BudgetCreate):
    id: int

    class Config:
        orm_mode = True
