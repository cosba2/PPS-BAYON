from flask_sqlalchemy import SQLAlchemy
import os

db = SQLAlchemy()

def init_app(app):
    app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv("DATABASE_URL", "postgresql://root:1l5B6H1E8HGDNrDRbi9W01CMK5MawuyG@dpg-cuu4qr1opnds739svkog-a.oregon-postgres.render.com/pps_bayon")
    #app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv("DATABASE_URL", "mysql+pymysql://root:18128993@localhost/blog_db")
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    API_KEY = os.getenv("API_KEY", "api_key")
    db.init_app(app)
