from sqlalchemy import Column, Integer, String, Float, Text, Date, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from datetime import datetime
from app.utils.database_connection import Base
from app.models.catagories import Categories

class Expense(Base):
    __tablename__ = 'expenses'

    id = Column(Integer, primary_key=True, index=True)
    user_name = Column(String(50), nullable=False)
    category_id = Column(Integer, ForeignKey('categories.id'))
    amount = Column(Float, nullable=False)
    description = Column(Text)
    date = Column(Date, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)

    # relationships
    category = relationship("Categories", back_populates="expenses")
