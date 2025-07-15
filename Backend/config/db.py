from flask_sqlalchemy import SQLAlchemy
import os

db = SQLAlchemy()

def init_app(app):
    app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv("DATABASE_URL", "postgresql://bdd_pps_user:aV4ajhEnqCkuiIdX9KXhHqXXLe1HKs1d@dpg-cvsjqnbuibrs73ehmsag-a/bdd_pps")
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    db.init_app(app)
