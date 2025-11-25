from sqlalchemy.orm import Session
from datetime import datetime,date
from typing import Optional
from app.models.expense import Expense

class ExpenseServices:
    def __init__(self, db: Session):
        self.db = db

    def list_all_expenses(self,user_name: Optional[str]= None,category_id: Optional[int] = None,min_amount: Optional[float] = None,max_amount: Optional[float] = None,start_date: Optional[date] = None,end_date: Optional[date] = None):
        """Retrieve all expenses for a user with optional filters:- category_id: filter by category- min_amount, max_amount: filter by amount range- start_date, end_date: filter by date range"""
        query = self.db.query(Expense).filter(Expense.user_name == user_name)
    
        if category_id is not None:
            query = query.filter(Expense.category_id == category_id)

        if min_amount is not None:
            query = query.filter(Expense.amount >= min_amount)

        if max_amount is not None:
            query = query.filter(Expense.amount <= max_amount)

        if start_date is not None:
            query = query.filter(Expense.date >= start_date)

        if end_date is not None:
            query = query.filter(Expense.date <= end_date)

        query = query.order_by(Expense.date.desc())

        return query.all()


    def add_new_expense(self,user_name,category_id,amount,description,date,created_at):
        """Adds a new expense entry to the database."""
        try:
            if created_at is None:
                created_at = datetime.utcnow()

            new_expense = Expense(
                user_name=user_name,
                category_id=category_id,
                amount=amount,
                description=description,
                date=date,
                created_at=created_at
            )

            self.db.add(new_expense)
            self.db.commit()
            self.db.refresh(new_expense)
            return new_expense

        except Exception as e:
            self.db.rollback()
            return "Internal Error"

    def update_expense(self,user_name: str,category_id: Optional[int] = None,amount: Optional[float] = None,description: Optional[str] = None,expense_date: Optional[date] = None,created_at: Optional[datetime] = None):
        """Update an expense for a user.Only the fields that are provided (not None) will be updated."""
        # Query the specific expense
        expense = self.db.query(Expense).filter(
            Expense.user_name == user_name,
            Expense.category_id == category_id,
            Expense.date == expense_date
        ).first()

        if not expense:
            raise ValueError(f"No expense found for user '{user_name}' with id {category_id}")

        # Update only the fields that are provided
        if category_id is not None:
            expense.category_id = category_id
        if amount is not None:
            expense.amount = amount
        if description is not None:
            expense.description = description
        if expense_date is not None:
            expense.date = expense_date
        if created_at is not None:
            expense.created_at = created_at

        # Commit the changes
        self.db.commit()
        self.db.refresh(expense)

        return expense

    def delete_expense(self,user_name: str,category_id: Optional[int] = None,expense_date: Optional[date] = None):
        """delete an expense for a user.Only the fields that are provided (not None) will be Deleted."""
        # Query the specific expense
        query = self.db.query(Expense).filter(Expense.user_name == user_name)

        if category_id is not None:
            query = query.filter(Expense.category_id == category_id)
        if expense_date is not None:
            query = query.filter(Expense.date == expense_date)

        deleted_count = query.delete(synchronize_session=False)
        self.db.commit()

        return deleted_count