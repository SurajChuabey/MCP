from fastapi import Depends, APIRouter
from app.utils.database_connection import get_db
from app.services.expense_service import ExpenseServices
from app.schema.expense import ExpenseAdd, ExpenseDelete, ExpenseList, ExpenseUpdate
from sqlalchemy.orm import Session

router = APIRouter()


@router.post('/getOverAllExpense')
def list_all_expanse(payload: ExpenseList, db: Session = Depends(get_db)):
    """Retrieve all expenses for a user with optional filters"""
    expense_service = ExpenseServices(db)
    overall_expense = expense_service.list_all_expenses(payload.user_name,payload.category_id,payload.min_amount,payload.max_amount,payload.start_date,payload.end_date)

    return overall_expense


@router.post('/addNewExpense')
def add_new_expense(payload: ExpenseAdd, db: Session = Depends(get_db)):
    """Add a new expense for a user"""
    expense_service = ExpenseServices(db)
    added_expense = expense_service.add_new_expense(payload.user_name,payload.category_id,payload.amount,payload.description,payload.date,payload.created_at)
    
    return added_expense


@router.post('/updateExpense')
def update_expense(payload: ExpenseUpdate, db: Session = Depends(get_db)):
    """Update an existing expense for a user"""
    expense_service = ExpenseServices(db)
    updated_expense = expense_service.update_expense(payload.user_name,payload.category_id,payload.amount,payload.description,payload.date,payload.created_at)
    
    return updated_expense


@router.post('/deleteExpense')
def delete_expense(payload: ExpenseDelete, db: Session = Depends(get_db)):
    """Delete expense(s) for a user based on optional filters"""
    expense_service = ExpenseServices(db)
    deleted_count = expense_service.delete_expense(payload.user_name,payload.category_id,payload.expense_date)

    return deleted_count
