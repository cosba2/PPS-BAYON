from flask import Flask, request, jsonify
from config.db import db, init_app
from models import User, Post, Comment
from routes.users_routes import user_routes
from routes.post_routes import post_routes
from routes.comment_routes import comment_routes
from flask_cors import CORS
import os

app = Flask(__name__)

# Configurar CORS permitiendo el frontend en Render
CORS(app, resources={r"/*": {"origins": "https://pps-bayon-1.onrender.com/api"}})

init_app(app)
with app.app_context():
    db.create_all()


API_KEY = os.getenv("API_KEY", "marcospps")
DATABASE_URL = os.getenv("DATABASE_URL")

print(f"API Key cargada: {API_KEY}")
print(f"Database URL: {DATABASE_URL}")

def require_api_key(func):
    """ Decorador para verificar API Key en rutas específicas """
    def wrapper(*args, **kwargs):
        api_key = request.headers.get("X-API-KEY") 
        if api_key != API_KEY:
            return jsonify({"error": "Acceso no autorizado"}), 403
        return func(*args, **kwargs)
    wrapper.__name__ = func.__name__
    return wrapper

@app.before_request
def validate_api_key():
    if request.method == "OPTIONS":
        return jsonify({"message": "Preflight OK"}), 200
    if not request.endpoint or request.endpoint == "static":
        return

    api_key = request.headers.get("X-API-KEY")
    if api_key != API_KEY:
        return jsonify({"error": "Acceso no autorizado"}), 403


@app.after_request
def add_cors_headers(response):
    """ Agregar headers CORS a todas las respuestas """
    response.headers["Access-Control-Allow-Origin"] = "https://pps-bayon-1.onrender.com/api"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Content-Type, Authorization, X-API-KEY"
    return response

@app.route('/api/<path:path>', methods=['OPTIONS'])
def handle_preflight(path):
    """ Manejo de solicitudes OPTIONS (preflight) para CORS """
    response = jsonify({"message": "Preflight OK"})
    response.headers["Access-Control-Allow-Origin"] = "https://pps-bayon-1.onrender.com/api"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Content-Type, Authorization, X-API-KEY"
    return response, 200

# Registrar rutas
app.register_blueprint(user_routes, url_prefix='/api')
app.register_blueprint(post_routes, url_prefix='/api')
app.register_blueprint(comment_routes, url_prefix='/api')

if __name__ == '__main__':
    app.run(debug=True)