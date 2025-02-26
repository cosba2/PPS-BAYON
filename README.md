# PPS-BAYON

## Descripción
Este es un proyecto desarrollado con **Flutter** para el frontend y **Flask** con **PostgreSQL** para el backend. Permite gestionar publicaciones, usuarios y comentarios mediante una API.

## Tecnologías utilizadas

### Frontend
- **Flutter**
- **Dart**
- **Render** (para el despliegue)

### Backend
- **Flask**
- **Python**
- **PostgreSQL**
- **Render** (para el despliegue)

## Estructura del Proyecto

- **Frontend:** [PPS-BAYON Frontend](https://pps-bayon-1.onrender.com/)
- **Backend:** [PPS-BAYON Backend](https://pps-bayon.onrender.com)
- **Repositorio Completo:** [GitHub](https://github.com/cosba2/PPS-BAYON)

- PARA CORRER EL PROYECTO INGRESAR AL LINK DEL FRONT.

## Compartir Colección de Postman

Para probar los endpoints de la API, puedes importar la colección de Postman disponible en el siguiente enlace:

[Descargar colección de Postman](https://github.com/cosba2/PPS-BAYON/blob/main/postman/PPS.postman_collection.json)

1. Abre Postman y ve a **File > Import**.
2. Selecciona el archivo `.json` descargado.
3. Una vez importado, podrás probar los endpoints directamente.


## Endpoints principales

### Publicaciones
- `GET /posts` - Obtener todas las publicaciones
- `POST /posts` - Crear una nueva publicación
- `PUT /posts/<id>` - Editar una publicación existente
- `DELETE /posts/<id>` - Eliminar una publicación

### Comentarios
- `GET /comments` - Obtener todos los comentarios
- `POST /comments` - Agregar un comentario
- `DELETE /comments/<id>` - Eliminar un comentario

### Usuarios
- `GET /users` - Obtener todos los usuarios
- `POST /users` - Registrar un nuevo usuario
- `DELETE /users/<id>` - Eliminar un usuario

## Contribución
Si deseas contribuir, sigue estos pasos:

1. Haz un fork del repositorio
2. Crea una nueva rama: `git checkout -b feature-nueva`
3. Realiza los cambios y haz commit: `git commit -m "Agregado nuevo feature"`
4. Sube los cambios a tu fork: `git push origin feature-nueva`
5. Abre un Pull Request en GitHub

## Licencia
Este proyecto está bajo la licencia MIT. Consulta el archivo `LICENSE` para más detalles.

---

**Desarrollado por:** [Tu Nombre / Equipo]










# PPS-BAYON

## Descripción
Este es un proyecto desarrollado con **Flutter** para el frontend y **Flask** con **PostgreSQL** para el backend. Permite gestionar publicaciones y comentarios mediante una API.

## Tecnologías utilizadas

### Frontend
- **Flutter**
- **Dart**
- **Render** (para el despliegue)

### Backend
- **Flask**
- **Python**
- **PostgreSQL**
- **Railway** (para la base de datos)
- **Render** (para el despliegue)

## Estructura del Proyecto

- **Frontend:** [PPS-BAYON Frontend](https://pps-bayon-1.onrender.com/)
- **Backend:** [PPS-BAYON Backend](https://pps-bayon.onrender.com)
- **Repositorio Completo:** [GitHub](https://github.com/cosba2/PPS-BAYON)

## Instalación y Ejecución

### Backend

1. Clonar el repositorio:
   ```bash
   git clone https://github.com/cosba2/PPS-BAYON.git
   cd PPS-BAYON/Backend
   ```
2. Crear y activar un entorno virtual:
   ```bash
   python -m venv venv
   source venv/bin/activate  # Linux/Mac
   venv\Scripts\activate  # Windows
   ```
3. Instalar dependencias:
   ```bash
   pip install -r requirements.txt
   ```
4. Configurar las variables de entorno (crear un archivo `.env` con los datos de la base de datos y configuraciones necesarias).
5. Ejecutar la aplicación:
   ```bash
   flask run
   ```

### Frontend

1. Clonar el repositorio y moverse a la carpeta del frontend:
   ```bash
   git clone https://github.com/cosba2/PPS-BAYON.git
   cd PPS-BAYON/Frontend
   ```
2. Instalar dependencias:
   ```bash
   flutter pub get
   ```
3. Ejecutar la aplicación:
   ```bash
   flutter run
   ```

## Endpoints principales

### Publicaciones
- `GET /posts` - Obtener todas las publicaciones
- `POST /posts` - Crear una nueva publicación
- `PUT /posts/<id>` - Editar una publicación existente
- `DELETE /posts/<id>` - Eliminar una publicación

### Comentarios
- `GET /comments` - Obtener todos los comentarios
- `POST /comments` - Agregar un comentario
- `DELETE /comments/<id>` - Eliminar un comentario

### Usuarios
- `GET /users` - Obtener todos los usuarios
- `POST /users` - Registrar un nuevo usuario
- `DELETE /users/<id>` - Eliminar un usuario


## Contribución
Si deseas contribuir, sigue estos pasos:

1. Haz un fork del repositorio
2. Crea una nueva rama: `git checkout -b feature-nueva`
3. Realiza los cambios y haz commit: `git commit -m "Agregado nuevo feature"`
4. Sube los cambios a tu fork: `git push origin feature-nueva`
5. Abre un Pull Request en GitHub

## Licencia
Este proyecto está bajo la licencia MIT. Consulta el archivo `LICENSE` para más detalles.

---

**Desarrollado por:** [Tu Nombre / Equipo]

