# tesismaestriauni-launcher

## Dev

1. Clonar el repositorio
2. Crear un .env basado en el .env.template
3. Ejecutar el comando `git submodule update --init --recursive` para reconstruir los sub-módulos
4. Ejecutar el comando `docker compose up --build`
5. Para actualizar referencias `git submodule update --remote`

### Pasos para crear los Git Submodules

1. Crear un nuevo repositorio en GitHub
2. Clonar el repositorio en la máquina local
3. Añadir el submodule, donde `repository_url` es la url del repositorio y `directory_name` es el nombre de la carpeta donde quieres que se guarde el sub-módulo (no debe de existir en el proyecto)

```
git submodule add <repository_url> <directory_name>
```

4. Añadir los cambios al repositorio (git add, git commit, git push)
   Ej:

```
git add .
git commit -m "Add submodule"
git push
```

5. Inicializar y actualizar Sub-módulos, cuando alguien clona el repositorio por primera vez, debe de ejecutar el siguiente comando para inicializar y actualizar los sub-módulos

```
git submodule update --init --recursive
```

6. Para actualizar las referencias de los sub-módulos

```
git submodule update --remote
```

## Importante

Si se trabaja en el repositorio que tiene los sub-módulos, **primero actualizar y hacer push** en el sub-módulo y **después** en el repositorio principal.

Si se hace al revés, se perderán las referencias de los sub-módulos en el repositorio principal y tendremos que resolver conflictos.

Claro, aquí tienes la documentación ampliada para tu `README.md`, con una sección al final que explica cómo eliminar submódulos de manera segura:

## 🐳 Comandos útiles de Docker

### Comandos básicos de Docker Compose

Si el archivo no se llama `docker-compose.yml`, agregar `-f nombre-archivo.yml` antes del comando. Ejemplo:

```bash
docker compose -f docker-compose.mcp.yml up
```

```bash
docker compose -p nombre-proyecto up
```

```bash
# Iniciar servicios
docker compose up

# Iniciar servicios en modo detached (background)
docker compose up -d

# Detener servicios
docker compose down

# Ver logs de los servicios
docker compose logs

# Ver logs de un servicio específico
docker compose logs nombre-servicio

# Ver logs en tiempo real
docker compose logs -f
```

### Comandos de construcción y reconstrucción

```bash
# Reconstruir todos los servicios
docker compose build

# Reconstruir un servicio específico
docker compose build nombre-servicio

# Reconstruir sin usar caché
docker compose build --no-cache

# Reconstruir y levantar servicios
docker compose up --build
```

### Comandos útiles de Docker

#### Construcción de imágenes

```bash
# Construir imagen con Dockerfile (nombre por defecto)
docker build -t nombre-imagen .

# Construir imagen con archivo que no se llama Dockerfile
docker build -f nombre-archivo.dockerfile -t nombre-imagen .

# Construir imagen con nombre y tag específicos
docker build -t nombre-imagen:tag .

# Construir sin usar caché
docker build --no-cache -t nombre-imagen .
```

#### Gestión de contenedores

```bash
# Ver contenedores en ejecución
docker ps

# Ver todos los contenedores (incluyendo detenidos)
docker ps -a

# Detener un contenedor
docker stop nombre-contenedor

# Eliminar un contenedor
docker rm nombre-contenedor

# Eliminar todos los contenedores detenidos
docker container prune
```

#### Gestión de imágenes

```bash
# Ver imágenes locales
docker images

# Eliminar una imagen
docker rmi nombre-imagen

# Eliminar imágenes sin usar
docker image prune

# Eliminar todas las imágenes sin usar
docker image prune -a
```

### Comandos de limpieza

```bash
# Eliminar contenedores, redes e imágenes sin usar
docker system prune

# Eliminar todo (contenedores, redes, imágenes y volúmenes)
docker system prune -a --volumes
```

### Comandos de inspección

```bash
# Ver detalles de un contenedor
docker inspect nombre-contenedor

# Ver logs de un contenedor
docker logs nombre-contenedor

# Ver logs en tiempo real
docker logs -f nombre-contenedor

# Ver uso de recursos
docker stats
```
