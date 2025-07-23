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

API_KEY = os.getenv("API_KEY")

app = Flask(__name__)

# ✅ CORS solo para rutas /api y para tu frontend
CORS(app, supports_credentials=True, resources={
    r"/api/*": {"origins": "*",
                 "allow_headers": ["Content-Type", "X-API-KEY"],
                 "methods": ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
                }
})

# ✅ Middleware unificado
@app.before_request
def verificar_api_key():
    if request.method == 'OPTIONS':
        from flask import make_response
        response = make_response()
        response.headers.add("Access-Control-Allow-Origin", "*")
        response.headers.add("Access-Control-Allow-Headers", "Content-Type, X-API-KEY")
        response.headers.add("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
        return response, 200

    # Rutas que no requieren API KEY
    rutas_publicas = ['/', '/login']
    if request.path in rutas_publicas:
        return

    # Solo verificar API KEY en rutas que empiezan con /api
    if request.path.startswith('/api'):
        api_key = request.headers.get("X-API-KEY")
        print(f'API KEY recibida: {api_key}')
        if api_key != API_KEY:
            return jsonify({"error": "API Key inválida"}), 401


# ✅ Ruta pública para probar si la API está viva
@app.route("/")
def health_check():
    return "API corriendo correctamente 🚀", 200

@app.route("/login", methods=["POST"])
def login():
    return jsonify({"msg": "Login permitido sin API Key"})

# Inicializar base de datos y Blueprints
init_app(app)

with app.app_context():
    db.create_all()

app.register_blueprint(user_routes, url_prefix='/api')
app.register_blueprint(post_routes, url_prefix='/api')
app.register_blueprint(comment_routes, url_prefix='/api')

if __name__ == '__main__':
    app.run(debug=True)
