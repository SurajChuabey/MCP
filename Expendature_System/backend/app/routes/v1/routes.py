from fastapi import APIRouter
from app.routes.v1.expense_routes import router as expense_router

v1_router = APIRouter()

v1_router.include_router(expense_router, prefix="/expense", tags=["expense"])