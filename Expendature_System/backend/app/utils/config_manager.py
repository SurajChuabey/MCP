import configparser
import os
from app.constants.constants import Constants

class ConfigManager:

    @staticmethod
    def read_config_file(file_path: str = None):
        """Read config.ini file from the given path."""
        config = configparser.ConfigParser()
        if not os.path.exists(file_path):
            raise FileNotFoundError(f"Config file not found at: {file_path}")
        
        config.read(file_path,encoding='utf-8')

        if not config.sections():
            raise ValueError(f"No sections found in config file: {file_path}")
        
        config_dict = {}
        for section in config.sections():
            config_dict[section] = {}
            for key, value in config.items(section):
                config_dict[section][key] = value

        return config_dict
    
    @staticmethod
    def config(env:str = None,param:str = None):
        """ Fetch value from config file for the given environment with parameter"""
        config_dict = ConfigManager.read_config_file(Constants.CONFIG_FILE_PATH)
        return config_dict[env][param.lower()]