#!/usr/bin/env bash
# Crear env.js con los valores reales de Render
echo "window.env = { API_BASE_URL: '$API_BASE_URL', API_KEY: '$API_KEY' };" > web/env.js

# Compilar Flutter Web
flutter build web --release
