#!/bin/bash
set -e

echo "=================================================="
echo "Configurando Django (sin instalar dependencias)"
echo "=================================================="

export DJANGO_SETTINGS_MODULE=asistencia.settings

echo "Ejecutando migraciones..."
python manage.py migrate --noinput

echo "Ejecutando collectstatic..."
python manage.py collectstatic --noinput --clear

echo ""
echo "=================================================="
echo "Build completado!"
echo "=================================================="
