# Obtener el directorio del script y la raíz del proyecto
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$projectRoot = Split-Path -Parent (Split-Path -Parent $scriptDir)

# Rutas relevantes
$downloadsDir = Join-Path $scriptDir "downloads"
$dataDir = Join-Path $projectRoot "others\data"

# Crear directorio de descargas si no existe
if (!(Test-Path $downloadsDir)) {
    New-Item -ItemType Directory -Path $downloadsDir | Out-Null
}

# Lista de carpetas a comprimir
$folders = @("budget-mcp-db", "documents-app-db", "message-app-db", "nginx-files", "qdrant")

# Función para comprimir
function Compress-Folder {
    param (
        [string]$sourceDir,
        [string]$destinationZip
    )

    if (Test-Path $destinationZip) {
        Remove-Item $destinationZip -Force
    }

    Write-Host "Comprimiendo $sourceDir en $destinationZip..."
    Compress-Archive -Path "$sourceDir\*" -DestinationPath $destinationZip
}

# Comprimir las carpetas
foreach ($folder in $folders) {
    $sourcePath = Join-Path $dataDir $folder
    $zipPath = Join-Path $downloadsDir "$folder.zip"

    if (Test-Path $sourcePath) {
        Compress-Folder -sourceDir $sourcePath -destinationZip $zipPath
    } else {
        Write-Warning "No se encontró la carpeta $sourcePath"
    }
}

Write-Host "Proceso de compresión completado."
