#!/bin/bash
set -e

echo "=================================================="
echo "Configurando Django (sin instalar dependencias)"
echo "=================================================="

export DJANGO_SETTINGS_MODULE=asistencia.settings

echo "Ejecutando migraciones..."
python manage.py migrate --noinput

echo "Creando superusuario (si no existe)..."
python - << 'EOF'
import os
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'asistencia.settings')
import django
django.setup()
from django.contrib.auth import get_user_model
User = get_user_model()
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@example.com', 'admin123')
    print('Superuser creado: admin/admin123')
else:
    print('Superuser ya existe')
EOF

echo "Ejecutando collectstatic..."
python manage.py collectstatic --noinput --clear

echo ""
echo "=================================================="
echo "Build completado!"
echo "=================================================="
