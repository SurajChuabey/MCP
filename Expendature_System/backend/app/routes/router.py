from fastapi import APIRouter
from app.routes.v1.routes import v1_router

api_router = APIRouter()

api_router.include_router(v1_router,prefix='/app/v1')