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

## Instalación y Ejecución

### Clonación del Repositorio
Para obtener una copia local del proyecto, ejecuta el siguiente comando:
```bash
git clone https://github.com/cosba2/PPS-BAYON.git
```
Luego, accede a la carpeta correspondiente dependiendo del entorno que desees ejecutar:
```bash
cd PPS-BAYON/Backend  # Para el backend
cd PPS-BAYON/Frontend  # Para el frontend
```

## Compartir Colección de Postman

Para probar los endpoints de la API, puedes importar la colección de Postman disponible en el siguiente enlace:

[Descargar colección de Postman](https://github.com/cosba2/PPS-BAYON/blob/main/postman/PPS.postman_collection.json)

1. Abre Postman y ve a **File > Import**.
2. Selecciona el archivo `.json` descargado.
3. Una vez importado, podrás probar los endpoints directamente.


## Endpoints principales

### La ruta principal para correr el los endpoints es:

https://pps-bayon.onrender.com/api

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

---

**Desarrollado por:** Bayon Marcos
