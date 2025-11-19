# ⚽ PlayTime - Plataforma de Reservas Deportivas

## ⚙️ 1. Configuración de la Base de Datos (MySQL)

Para que la aplicación funcione, es indispensable restaurar el esquema de la base de datos `playtime_db`.

### 1.1 Restauración del Esquema

El repositorio contiene el archivo `playtime_db_dump.sql` en la carpeta `/db`. Este archivo contiene tanto la estructura de las tablas como los datos iniciales necesarios para probar (ej. Deportes, Complejos).

**Pasos para restaurar:**

1.  Abre **MySQL Workbench** o tu cliente SQL preferido.
2.  Ejecuta el archivo `playtime_db_dump.sql`.
    * **En la Consola de MySQL:**
        ```sql
        SOURCE /ruta/absoluta/a/este/proyecto/db/playtime_db_dump.sql;
        ```
    * **(Recomendado)** **En MySQL Workbench:** Usa **Server** > **Data Import** y selecciona "Import from Self-Contained File".


## 🚀 2. Configuración del Servidor (GlassFish)

La aplicación utiliza un Pool de Conexiones JNDI para acceder a la base de datos de manera eficiente.

### 2.1 Creación del Pool de Conexiones

Debe crear un nuevo **JDBC Connection Pool** en su servidor GlassFish con el nombre **`playtime_dbPool`** para que la aplicación pueda inyectar el recurso JNDI `jdbc/playtime`.

| Propiedad | Valor Requerido | Observación |
| :--- | :--- | :--- |
| **Pool Name** | `playtime_dbPool` | Debe coincidir exactamente. |
| **Resource Name (JNDI)** | `jdbc/playtime` | Debe coincidir con la referencia en `persistence.xml`. |
| **DataSource Classname** | `com.mysql.cj.jdbc.MysqlDataSource` | Driver para MySQL 8.0+. |
| **Database Name** | `playtime_db` | El esquema que acaba de restaurar. |
| **User** | **[SU USUARIO DE MYSQL]** | Ingrese su usuario local (ej. `root`). |
| **Password** | **[SU CONTRASEÑA DE MYSQL]** | Ingrese su contraseña local. |

Una vez que el pool esté configurado, el proyecto puede ser desplegado.
