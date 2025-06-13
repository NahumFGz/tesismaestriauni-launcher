# Obtener el directorio del script y la raíz del proyecto
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$projectRoot = Split-Path -Parent (Split-Path -Parent $scriptDir)

# Definir rutas
$downloadsDir = Join-Path $scriptDir "downloads"
$dataDir = Join-Path $projectRoot "others\data"

# Crear directorio de destino si no existe
if (!(Test-Path $dataDir)) {
    New-Item -ItemType Directory -Path $dataDir | Out-Null
}

# Función para descomprimir archivos ZIP
function Expand-ZipFile {
    param (
        [string]$zipFile,
        [string]$targetRoot
    )

    $zipName = [System.IO.Path]::GetFileNameWithoutExtension($zipFile)
    $destination = Join-Path $targetRoot $zipName

    Write-Host "Descomprimiendo $zipFile en $destination..."
    if (!(Test-Path $destination)) {
        New-Item -ItemType Directory -Path $destination | Out-Null
    }

    Expand-Archive -Path $zipFile -DestinationPath $destination -Force
}

# Lista de archivos ZIP a descomprimir
$zipFiles = @(
    "budget-mcp-db.zip",
    "documents-app-db.zip",
    "message-app-db.zip",
    "nginx-files.zip",
    "qdrant.zip"
)

# Procesar cada archivo
foreach ($zipName in $zipFiles) {
    $zipPath = Join-Path $downloadsDir $zipName
    if (Test-Path $zipPath) {
        Expand-ZipFile -zipFile $zipPath -targetRoot $dataDir
    } else {
        Write-Warning "No se encontró el archivo $zipPath"
    }
}

Write-Host "Proceso de descompresión completado."
