import os
import pymysql
from flask import Flask
from flask_cors import CORS
from config.db import db  # Importa db desde config.db
from models.user import User  # Importa los modelos
from models.post import Post
from models.comment import Comment
from routes.post_routes import post_routes
from routes.comment_routes import comment_routes
from routes.users_routes import user_routes

pymysql.install_as_MySQLdb()

app = Flask(__name__)
CORS(app)

# Configuración de la base de datos
app.config["SQLALCHEMY_DATABASE_URI"] = SQLALCHEMY_DATABASE_URI
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False


# Inicializa SQLAlchemy con la aplicación
db.init_app(app)

# Crear tablas en la base de datos
with app.app_context():
    db.create_all()  # Crea las tablas en MySQL

# Registrar rutas
app.register_blueprint(post_routes, url_prefix='/api')
app.register_blueprint(comment_routes, url_prefix='/api')
app.register_blueprint(user_routes, url_prefix='/api')

if __name__ == '__main__':
    app.run(debug=True)