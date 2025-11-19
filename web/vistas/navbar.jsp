<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 
    Fragmento de la barra de navegación inferior (Tapbar).
    Este componente requiere que la página que lo incluye establezca una variable de request:
    <c:set var="activePage" value="[home|buscar|reservas|comunidad|perfil]" scope="request"/>
--%>

<footer class="bottom-nav">
    <nav class="nav nav-justified">
        <a class="nav-link ${activePage == 'home' ? 'active' : ''}" href="${pageContext.request.contextPath}/ManejadorServlet?action=home">
            <i class="bi bi-house-door-fill"></i>
            <span>Inicio</span>
        </a>
        <a class="nav-link ${activePage == 'torneos' ? 'active' : ''}" href="${pageContext.request.contextPath}/vistas/EnConstruccion.jsp">
            <i class="bi bi-trophy"></i>
            <span>Torneos</span>
        </a>
        <a class="nav-link ${activePage == 'reservas' ? 'active' : ''}" href="${pageContext.request.contextPath}/reservas?action=mis_reservas">
            <i class="bi bi-calendar-check"></i>
            <span>Reservas</span>
        </a>
        <a class="nav-link ${activePage == 'comunidad' ? 'active' : ''}" href="${pageContext.request.contextPath}/ManejadorServlet?action=comunidad">
            <i class="bi bi-people"></i>
            <span>Comunidad</span>
        </a>
        <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#confirmLogoutModal">
            <i class="bi bi-box-arrow-right"></i>
            <span>Salir</span>
        </a>
    </nav>
</footer>

<%-- 
    Este modal de logout se incluye aquí porque el botón que lo activa está en la navbar.
    De esta forma, cualquier página que incluya la navbar tendrá acceso a este modal.
--%>
<div class="modal fade" id="confirmLogoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius: 16px; border: none;">
            <div class="modal-header border-0">
                <h5 class="modal-title fw-bold" id="logoutModalLabel">
                    <i class="bi bi-box-arrow-right text-warning me-2"></i>
                    Cerrar Sesión
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                ¿Estás seguro de que deseas cerrar sesión?
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="border-radius: 8px;">
                    Cancelar
                </button>
                <a href="${pageContext.request.contextPath}/UsuarioServlet?action=logout" 
                   class="btn btn-danger" 
                   style="border-radius: 8px;">
                    Cerrar Sesión
                </a>
            </div>
        </div>
    </div>
</div>
