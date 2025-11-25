from sqlalchemy import Column, String, Float, Date, Integer, ForeignKey
from sqlalchemy.orm import relationship
from app.utils.database_connection import Base

class Budget(Base):
    __tablename__ = 'budgets'

    id = Column(Integer, primary_key=True, autoincrement=True)
    user_name = Column(String(50), nullable=False)
    month = Column(Date, nullable=False)
    budget_amount = Column(Float, nullable=False)
    category_id = Column(Integer, ForeignKey('categories.id'))  # linked category
    sub_category = Column(String(50), nullable=True)

    # relationship
    category = relationship("Categories", back_populates="budgets")
