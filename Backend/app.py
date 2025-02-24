from flask import Flask
from config.db import db, init_app
from models import User, Post, Comment
from routes.users_routes import user_routes
from routes.post_routes import post_routes
from routes.comment_routes import comment_routes
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

init_app(app)

with app.app_context():
    db.create_all()  # Crea las tablas en PostgreSQL si no existen

# Registrar rutas
app.register_blueprint(user_routes, url_prefix='/api')
app.register_blueprint(post_routes, url_prefix='/api')
app.register_blueprint(comment_routes, url_prefix='/api')

if __name__ == '__main__':
    app.run(debug=True)
