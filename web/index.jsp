<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bienvenido a PlayTime</title>
    
    <!-- 1. Cargamos Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- 2. Enlazamos nuestra hoja de estilos personalizada -->
    <!-- (Asegúrate de crear una carpeta 'css' en 'Web Pages' y poner el archivo style.css allí) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    
</head>
<!-- 3. Aplicamos el fondo gradiente y las clases de centrado de Bootstrap -->
<body class="body-gradient d-flex align-items-center py-5">

    <!-- Contenedor principal de Bootstrap -->
    <div class="container animate-fade-in">
        <div class="row justify-content-center">
            <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                
                <!-- 4. Tarjeta de bienvenida (estilo definido en style.css) -->
                <div class="welcome-card text-center text-white">
                    
                    <!-- SECCIÓN SUPERIOR: Logo y Título -->
                    <div class="logo-container d-flex align-items-center justify-content-center mx-auto">
                        <span class="display-3" role="img" aria-label="Pelota de fútbol">⚽</span>
                    </div>
                    
                    <h1 class="display-4 fw-bold text-white mt-4">
                        PlayTime
                    </h1>
                    
                    <p class="fs-5 text-white-75 mt-2 fw-light">
                        Reservá tu cancha en segundos
                    </p>

                    <!-- SECCIÓN CENTRAL: Características -->
                    <div class="mt-4 text-start">
                        <div class="feature-item d-flex align-items-center mt-3">
                            <svg class="bi flex-shrink-0" width="24" height="24" fill="currentColor" viewBox="0 0 16 16"><path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/></svg>
                            <span class="ms-3 fs-6 fw-medium">Buscá canchas disponibles</span>
                        </div>
                        <div class="feature-item d-flex align-items-center mt-3">
                             <svg class="bi flex-shrink-0" width="24" height="24" fill="currentColor" viewBox="0 0 16 16"><path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/></svg>
                            <span class="ms-3 fs-6 fw-medium">Reservá en tiempo real</span>
                        </div>
                        <div class="feature-item d-flex align-items-center mt-3">
                            <svg class="bi flex-shrink-0" width="24" height="24" fill="currentColor" viewBox="0 0 16 16"><path d="M15 14s1 0 1-1-1-4-5-4-5 3-5 4S7 14 15 14zm-7.978-1A.261.261 0 0 1 7 12.996c.001-.264.167-1.03.76-1.72C8.312 10.629 9.282 10 11 10c1.717 0 2.687.63 3.24 1.276.593.69.758 1.457.76 1.72l-.008.002a.274.274 0 0 1-.25.22H7.022zM11 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4zm3-2a3 3 0 1 1-6 0 3 3 0 0 1 6 0zM6.936 9.28a5.88 5.88 0 0 0-1.23-.247A7.35 7.35 0 0 0 5 9c-4 0-5 3-5 4 0 .667.333 1 1 1h4.216A2.238 2.238 0 0 1 5 13c0-1.01.377-2.042 1.09-2.904.243-.294.526-.569.846-.816zM4.92 10A5.493 5.493 0 0 0 4 10.5C3.161 10.5 2.5 11.31 2.5 12c0 .69.661 1.5 1.5 1.5.91 0 1.638-.56 2.083-1.316C6.66 11.173 6.92 10.563 6.936 9.28zM3 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4zm0-3a3 3 0 1 1 6 0 3 3 0 0 1-6 0z"/></svg>
                            <span class="ms-3 fs-6 fw-medium">Conectá con otros jugadores</span>
                        </div>
                    </div>

                    <!-- 6. SECCIÓN INFERIOR: Botones de Acción (ahora con clases Bootstrap) -->
                    <!-- Estos enlaces apuntan al UsuarioServlet para manejar la navegación -->
                    <div class="mt-5 d-grid gap-3">
                        
                        <!-- Botón "Crear Cuenta" -->
                        <a href="${pageContext.request.contextPath}/UsuarioServlet?action=mostrar_registro" 
                           class="btn btn-success btn-lg rounded-3 shadow-lg d-flex align-items-center justify-content-center py-3 fw-bold">
                            <svg class="bi" width="20" height="20" fill="currentColor" viewBox="0 0 16 16"><path d="M6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H1s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/><path fill-rule="evenodd" d="M13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z"/></svg>
                            <span class="ms-2">Crear Cuenta</span>
                        </a>
                        
                        <!-- Botón "Iniciar Sesión" (Estilo "Outlined" de Flutter) -->
                        <a href="${pageContext.request.contextPath}/UsuarioServlet?action=mostrar_login" 
                           class="btn btn-outline-light btn-lg rounded-3 shadow-lg d-flex align-items-center justify-content-center py-3 fw-bold">
                            <svg class="bi" width="20" height="20" fill="currentColor" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M10 3.5a.5.5 0 0 0-.5-.5h-8a.5.5 0 0 0-.5.5v9a.5.5 0 0 0 .5.5h8a.5.5 0 0 0 .5-.5v-2a.5.5 0 0 1 1 0v2A1.5 1.5 0 0 1 9.5 14h-8A1.5 1.5 0 0 1 0 12.5v-9A1.5 1.5 0 0 1 1.5 2h8A1.5 1.5 0 0 1 11 3.5v2a.5.5 0 0 1-1 0v-2z"/><path fill-rule="evenodd" d="M4.146 8.354a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H14.5a.5.5 0 0 1 0 1H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3z"/></svg>
                            <span class="ms-2">Iniciar Sesión</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 7. Cargamos Bootstrap JS (necesario para futuros componentes) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>