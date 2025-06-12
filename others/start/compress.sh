#!/bin/bash

# Obtener la ruta base del proyecto
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

# Definir rutas
DOWNLOADS_DIR="$SCRIPT_DIR/downloads"
DATA_DIR="$PROJECT_ROOT/others/data"

# Crear directorio de descargas si no existe
mkdir -p "$DOWNLOADS_DIR"

# Función para comprimir directorios
compress_dir() {
    local source_dir="$1"
    local zip_file="$2"
    echo "Comprimiendo $source_dir en $zip_file..."
    cd "$source_dir" && zip -r "$zip_file" . && cd - > /dev/null
}

# Comprimir archivos desde others/data
for dir in budget-mcp-db documents-app-db message-app-db nginx-files qdrant; do
    if [ -d "$DATA_DIR/$dir" ]; then
        compress_dir "$DATA_DIR/$dir" "$DOWNLOADS_DIR/$dir.zip"
    else
        echo "Advertencia: No se encontró el directorio $DATA_DIR/$dir"
    fi
done

echo "Proceso de compresión completado." 