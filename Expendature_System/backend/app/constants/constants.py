import os
from pathlib import Path
current_dir = Path.cwd()

class Constants:
    """ Store constants across the project"""
    CONFIG_FILE_PATH = os.path.join(current_dir,'app/config/config.ini')


    # project env
    DEFAULTS = 'DEFAULTS'
    HOST = 'HOST'
    PORT = 'PORT'   
    # DATABASE CONSTANTS
    DATABASE_URL = 'DATABASE_URL'
