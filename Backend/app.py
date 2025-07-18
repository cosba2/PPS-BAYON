from flask import Flask, request, jsonify
from flask_cors import CORS
from config.db import db, init_app
from models import User, Post, Comment
from routes.users_routes import user_routes
from routes.post_routes import post_routes
from routes.comment_routes import comment_routes
import os
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.getenv("X-API-KEY")

app = Flask(__name__)

CORS(app, supports_credentials=True, resources={
    r"/api/*": {"origins": "https://pps-bayon-1.onrender.com/api"}
})

@app.before_request
def verify_api_key():
    api_key = request.headers.get('X-API-KEY')
    print(f'API KEY recibida: {api_key}')  # Esto te ayuda a depurar
    if api_key != 'marcospps':
        return jsonify({'error': 'Unauthorized'}), 401


# ========== MIDDLEWARE DE AUTORIZACIÓN POR API KEY ==========
@app.before_request
def validar_api_key():
    # Permitir preflight de CORS (Flutter web usa OPTIONS)
    if request.method == 'OPTIONS':
        return

    # Rutas públicas que no necesitan API KEY
    rutas_publicas = ['/login']

    if request.path in rutas_publicas:
        return

    # Verificación de API KEY
    api_key = request.headers.get("X-API-KEY")
    if api_key != API_KEY:
        return jsonify({"error": "API Key invalida"}), 401


# ========== RUTA PÚBLICA ==========
@app.route("/login", methods=["POST"])
def login():
    return jsonify({"msg": "Login permitido sin API Key"})


# ========== INICIALIZACIÓN DE LA APP ==========
init_app(app)

with app.app_context():
    db.create_all()  # Crea las tablas en PostgreSQL si no existen

# Registrar Blueprints
app.register_blueprint(user_routes, url_prefix='/api')
app.register_blueprint(post_routes, url_prefix='/api')
app.register_blueprint(comment_routes, url_prefix='/api')

# ========== EJECUCIÓN LOCAL ==========
if __name__ == '__main__':
    app.run(debug=True)
