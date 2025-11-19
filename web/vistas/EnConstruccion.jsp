<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>En Construcción - PlayTime</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <main class="container mt-5">
        <div class="text-center">
            <i class="bi bi-tools" style="font-size: 5rem; color: var(--primary-blue);"></i>
            <h1 class="display-5 fw-bold mt-4">Página en Construcción</h1>
            <p class="col-lg-6 mx-auto lead">
                Estamos trabajando duro para traerte una increíble sección de torneos.
                ¡Vuelve pronto para descubrirla!
            </p>
            <a href="${pageContext.request.contextPath}/vistas/home.jsp" class="btn btn-primary btn-lg mt-3">
                <i class="bi bi-house-door-fill me-2"></i>
                Volver al Inicio
            </a>
        </div>
    </main>

    <%-- Incluir la barra de navegación, indicando que 'torneos' es la página activa --%>
    <c:set var="activePage" value="torneos" scope="request"/>
    <jsp:include page="/vistas/navbar.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
