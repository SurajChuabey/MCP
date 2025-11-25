from sqlalchemy import Column, String, Integer, DateTime
from sqlalchemy.orm import relationship
from datetime import datetime
from app.utils.database_connection import Base
from app.models.budget import Budget

class Categories(Base):
    __tablename__ = 'categories'

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(50), nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)
    catagory_id = Column(Integer, nullable=False)
    # relationships
    expenses = relationship("Expense", back_populates="category")
    budgets = relationship("Budget", back_populates="category")
