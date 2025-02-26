# Imagen base con Flutter y herramientas necesarias
FROM cirrusci/flutter:latest AS build

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar todos los archivos del proyecto
COPY . .

# Construir la aplicación Flutter para la web
RUN flutter build web

# Segunda etapa: Servidor para servir los archivos estáticos
FROM nginx:alpine

# Copiar los archivos generados por Flutter a Nginx
COPY --from=build /app/build/web /usr/share/nginx/html

# Exponer el puerto 80
EXPOSE 80

# Iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
