from dotenv import load_dotenv
import os

load_dotenv()  # Carga las variables desde el archivo .env

DATABASE_URL = (
    f"mysql+pymysql://{os.getenv('MYSQLUSER')}:{os.getenv('MYSQLPASSWORD')}"
    f"@{os.getenv('MYSQLHOST')}:{os.getenv('MYSQLPORT')}/{os.getenv('MYSQLDATABASE')}"
)
