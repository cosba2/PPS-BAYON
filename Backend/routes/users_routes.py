from flask import Blueprint, request, jsonify
from config.db import db  # Asegura que tomamos db desde config.db
from models.user import User

user_routes = Blueprint('user_routes', __name__)

# Obtener todos los usuarios
@user_routes.route('/users', methods=['GET'])
def get_users():
    users = User.query.all()
    return jsonify([user.to_dict() for user in users])

# Obtener un usuario por ID
@user_routes.route('/users/<int:id>', methods=['GET'])
def get_user(id):
    user = User.query.get(id)
    if not user:
        return jsonify({'error': 'Usuario no encontrado'}), 404
    return jsonify(user.to_dict())

# Crear un usuario
@user_routes.route('/users', methods=['POST'])
def create_user():
    data = request.json
    if not data.get('username') or not data.get('email'):
        return jsonify({'error': 'Faltan datos'}), 400

    new_user = User(username=data['username'], email=data['email'])
    db.session.add(new_user)
    db.session.commit()
    return jsonify(new_user.to_dict()), 201

# Modificar un usuario
@user_routes.route('/users/<int:id>', methods=['PUT'])
def update_user(id):
    user = User.query.get(id)
    if not user:
        return jsonify({'error': 'Usuario no encontrado'}), 404

    data = request.json
    user.username = data.get('username', user.username)
    user.email = data.get('email', user.email)

    db.session.commit()
    return jsonify(user.to_dict())

# Eliminar un usuario
@user_routes.route('/users/<int:id>', methods=['DELETE'])
def delete_user(id):
    user = User.query.get(id)
    if not user:
        return jsonify({'error': 'Usuario no encontrado'}), 404

    db.session.delete(user)
    db.session.commit()
    return jsonify({'message': 'Usuario eliminado'}), 200
