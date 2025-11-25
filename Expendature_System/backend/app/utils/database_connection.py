
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker,declarative_base
from app.constants.constants import Constants
from app.utils.config_manager import ConfigManager

engine = create_engine(ConfigManager.config(Constants.DEFAULTS,Constants.DATABASE_URL))
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()
# Dependency to get database session
def get_db():
    """
    Provides a database session for request handling.

    This function initializes a new database session using `SessionLocal` and ensures
    it is properly closed after the request is completed.

    Yields:
        Session: A SQLAlchemy database session.

    Usage:
        The function is typically used as a FastAPI dependency for routes 
        that require database access.
    """
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()