from flask import Flask, request, jsonify
from config.db import db, init_app
from models import User, Post, Comment
from routes.users_routes import user_routes
from routes.post_routes import post_routes
from routes.comment_routes import comment_routes
from flask_cors import CORS
import os

app = Flask(__name__)
CORS(app)

init_app(app)

API_KEY = os.getenv("API_KEY", "default_key")
print(f"API Key cargada: {API_KEY}")

def require_api_key(func):
    def wrapper(*args, **kwargs):
        api_key = request.headers.get("X-API-KEY") 
        if api_key != API_KEY:
            return jsonify({"error": "Acceso no autorizado"}), 403
        return func(*args, **kwargs)
    wrapper.__name__ = func.__name__
    return wrapper

# Registrar rutas con validación de API Key
@app.before_request
def validate_api_key():
    """ Middleware para validar la API Key en todas las rutas """
    if request.endpoint in ["static"]:
        return
    
    print("Headers recibidos:", request.headers)  # Agregar esto para depuración
    api_key = request.headers.get("x--api-key")
    
    if api_key != API_KEY:
        print(f"API Key inválida: {api_key}")  # Agregar esto para depuración
        return jsonify({"error": "Acceso no autorizado"}), 403


# Registrar rutas
app.register_blueprint(user_routes, url_prefix='/api')
app.register_blueprint(post_routes, url_prefix='/api')
app.register_blueprint(comment_routes, url_prefix='/api')

if __name__ == '__main__':
    app.run(debug=True)
