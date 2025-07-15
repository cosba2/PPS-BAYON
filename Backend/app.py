from flask import Flask, request, jsonify
from config.db import db, init_app
from models import User, Post, Comment
from routes.users_routes import user_routes
from routes.post_routes import post_routes
from routes.comment_routes import comment_routes
from flask_cors import CORS
import os

app = Flask(__name__)

# ====================== CONFIGURAR CORS ======================
CORS(app, supports_credentials=True,
     resources={r"/api/*": {"origins": os.getenv("CORS_ORIGINS", "*")}},
     allow_headers=["Content-Type", "Authorization", "X-API-KEY", "X-Requested-With"],
     expose_headers=["X-API-KEY"],
     methods=["GET", "POST", "PUT", "DELETE", "OPTIONS"])

# ====================== CONFIGURAR BASE DE DATOS ======================
init_app(app)
with app.app_context():
    db.create_all()

# ====================== VARIABLES DE ENTORNO ======================
API_KEY = os.getenv("API_KEY")
if not API_KEY:
    raise ValueError("La variable de entorno API_KEY no está configurada.")

# ====================== VERIFICAR API KEY ======================
@app.before_request
def validate_api_key():
    api_key = request.headers.get("Authorization")
    print(f"Authorization Header: {api_key}")  # Log para depuración
    if request.method == "OPTIONS":
        return jsonify({"message": "Preflight OK"}), 200
    if not request.endpoint or request.endpoint == "static":
        return
    if not api_key or api_key != f"{API_KEY}":
        print("Acceso no autorizado")  # Log para depuración
        return jsonify({"error": "Acceso no autorizado"}), 403

# ====================== RESPUESTAS CORS ======================
@app.after_request
def add_cors_headers(response):
    response.headers["Access-Control-Allow-Origin"] = os.getenv("CORS_ORIGINS", "*")
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Content-Type, Authorization, X-API-KEY"
    return response

# ====================== OPCIONES (Preflight) ======================
@app.route('/api/<path:path>', methods=['OPTIONS'])
def handle_preflight(path):
    response = jsonify({"message": "Preflight OK"})
    response.headers["Access-Control-Allow-Origin"] = os.getenv("CORS_ORIGINS", "*")
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Content-Type, Authorization, X-API-KEY"
    return response, 200

# ====================== RUTAS ======================
app.register_blueprint(user_routes, url_prefix='/api')
app.register_blueprint(post_routes, url_prefix='/api')
app.register_blueprint(comment_routes, url_prefix='/api')

# ====================== EJECUTAR ======================
if __name__ == '__main__':
    app.run(debug=os.getenv("FLASK_DEBUG", "True").lower() == "true")
