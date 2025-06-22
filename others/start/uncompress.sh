#!/bin/bash

# Obtener la ruta base del proyecto
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

# Definir rutas
DOWNLOADS_DIR="$SCRIPT_DIR/downloads"
DATA_DIR="$PROJECT_ROOT/others/data"

# Crear directorios si no existen
mkdir -p "$DATA_DIR"

# Función para descomprimir archivos
unzip_file() {
    local zip_file="$1"
    local target_dir="$2"
    local zip_name=$(basename "$zip_file" .zip)
    local final_dir="$target_dir/$zip_name"
    
    echo "Descomprimiendo $zip_file en $final_dir..."
    mkdir -p "$final_dir"
    unzip -o "$zip_file" -d "$final_dir"
}

# Descomprimir archivos en others/data
for zip_file in "$DOWNLOADS_DIR"/{procurement-mcp-db.zip,documents-app-db.zip,chat-app-db.zip,nginx-files.zip,db-qdrant.zip}; do
    if [ -f "$zip_file" ]; then
        unzip_file "$zip_file" "$DATA_DIR"
    else
        echo "Advertencia: No se encontró el archivo $zip_file"
    fi
done

echo "Proceso de descompresión completado." 