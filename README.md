# tesismaestriauni-launcher

## Dev

1. Clonar el repositorio
2. Crear un .env basado en el .env.template
3. Ejecutar el comando `git submodule update --init --recursive` para reconstruir los sub-módulos
4. Ejecutar el comando `docker compose up --build`

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

---

### 🧹 Pasos para eliminar un Git Submodule

Supongamos que el submódulo está en la carpeta `submodules/mi-submodulo`.

1. **Eliminar la entrada del submódulo del archivo `.gitmodules`:**

   ```bash
   git config -f .gitmodules --remove-section submodule.submodules/mi-submodulo
   ```

   También puedes editar manualmente `.gitmodules` y eliminar la sección correspondiente.

2. **Eliminar la configuración del submódulo en `.git/config`:**

   ```bash
   git config --remove-section submodule.submodules/mi-submodulo
   ```

3. **Eliminar el submódulo del índice de Git:**

   ```bash
   git rm --cached submodules/mi-submodulo
   ```

4. **Eliminar la carpeta física del submódulo:**

   ```bash
   rm -rf submodules/mi-submodulo
   ```

5. **Eliminar los datos internos del submódulo (en `.git/modules`):**

   ```bash
   rm -rf .git/modules/submodules/mi-submodulo
   ```

6. **Hacer commit de los cambios:**

   ```bash
   git commit -m "Remove submodule submodules/mi-submodulo"
   git push
   ```
