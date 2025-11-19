<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Reservas - PlayTime</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    
    <style>
        :root {
            --primary-blue: #2563eb;
            --primary-blue-dark: #1e40af;
            --success-green: #10b981;
        }

        body {
            background-color: #f9fafb;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            padding-bottom: 80px;
        }

        /* ==== HEADER CON GRADIENTE ==== */
        .main-header {
            background: linear-gradient(90deg, var(--primary-blue) 0%, var(--primary-blue-dark) 100%);
            color: white;
            padding: 1rem 0;
        }

        .header-icon {
            width: 48px;
            height: 48px;
            background-color: rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* ==== CARD NUEVA RESERVA ==== */
        .new-reservation-card {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--primary-blue-dark) 100%);
            border-radius: 16px;
            padding: 2rem;
            text-align: center;
            box-shadow: 0 8px 20px rgba(37, 99, 235, 0.3);
            transition: all 0.3s;
            margin-bottom: 2rem;
        }

        .new-reservation-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 28px rgba(37, 99, 235, 0.4);
        }

        .new-reservation-icon {
            width: 64px;
            height: 64px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
        }

        .new-reservation-card h5 {
            color: white;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .new-reservation-card p {
            color: rgba(255, 255, 255, 0.9);
            margin: 0;
        }

        /* ==== CARDS DE RESERVAS ==== */
        .reservation-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 1rem;
            transition: all 0.2s;
        }

        .reservation-card:hover {
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.12);
            transform: translateY(-2px);
        }

        .reservation-header {
            background: linear-gradient(135deg, #34d399 0%, #10b981 100%);
            padding: 1.25rem;
            color: white;
        }

        .reservation-badge {
            background: rgba(255, 255, 255, 0.3);
            padding: 0.375rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            display: inline-block;
        }

        .complex-icon {
            width: 48px;
            height: 48px;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .reservation-body {
            padding: 1.25rem;
        }

        .info-row {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.75rem;
            color: #6b7280;
        }

        .info-row i {
            color: var(--primary-blue);
            font-size: 1rem;
        }

        .badge-guest {
            background: rgba(59, 130, 246, 0.1);
            color: #1e40af;
            padding: 0.25rem 0.75rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .badge-upcoming {
            background: rgba(16, 185, 129, 0.1);
            color: #065f46;
            padding: 0.375rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8125rem;
            font-weight: 600;
        }

        /* ==== BOTONES ==== */
        .btn-action {
            border-radius: 8px;
            font-weight: 500;
            padding: 0.5rem 1rem;
            transition: all 0.2s;
        }

        .btn-team {
            background: var(--primary-blue);
            color: white;
            border: none;
        }

        .btn-team:hover {
            background: var(--primary-blue-dark);
            transform: translateY(-1px);
        }

        .btn-cancel {
            background: rgba(239, 68, 68, 0.1);
            color: #dc2626;
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .btn-cancel:hover {
            background: rgba(239, 68, 68, 0.2);
        }

        .btn-leave {
            background: rgba(245, 158, 11, 0.1);
            color: #d97706;
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .btn-leave:hover {
            background: rgba(245, 158, 11, 0.2);
        }

        /* ==== ALERTAS ==== */
        .alert {
            border-radius: 12px;
            border: none;
            padding: 1rem 1.25rem;
        }

        .alert-success {
            background-color: #d1fae5;
            color: #065f46;
        }

        .alert-danger {
            background-color: #fee2e2;
            color: #991b1b;
        }

        .alert-info {
            background-color: #dbeafe;
            color: #1e40af;
        }

        /* ==== EMPTY STATE ==== */
        .empty-state {
            background: white;
            border-radius: 16px;
            padding: 3rem 2rem;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .empty-state-icon {
            font-size: 4rem;
            color: #d1d5db;
            margin-bottom: 1.5rem;
        }

        .empty-state h5 {
            font-weight: bold;
            color: #1f2937;
            margin-bottom: 0.75rem;
        }

        .empty-state p {
            color: #6b7280;
        }

        /* ==== MODALES ==== */
        .modal-content {
            border-radius: 16px;
            border: none;
        }

        .modal-header {
            border-bottom: 1px solid #e5e7eb;
        }

        .modal-footer {
            border-top: 1px solid #e5e7eb;
        }

        /* ==== RESPONSIVE ==== */
        @media (max-width: 768px) {
            .reservation-actions {
                display: flex;
                flex-direction: column;
                gap: 0.5rem;
            }

            .btn-action {
                width: 100%;
            }
        }
    </style>
</head>
<body>

    <!-- ==== HEADER CON GRADIENTE ==== -->
    <header class="main-header">
        <div class="container">
            <div class="d-flex align-items-center">
                <div class="flex-grow-1">
                    <h1 class="h4 mb-0 fw-bold">Mis Reservas</h1>
                    <p class="mb-0 small opacity-75">Gestioná tus partidos</p>
                </div>
                <div class="header-icon">
                    <i class="bi bi-calendar-month fs-4"></i>
                </div>
            </div>
        </div>
    </header>

    <!-- ==== CONTENIDO PRINCIPAL ==== -->
    <main class="container py-4">

        <!-- ==== CARD: NUEVA RESERVA ==== -->
        <a href="${pageContext.request.contextPath}/ComplejoServlet?action=listar" class="text-decoration-none">
            <div class="new-reservation-card">
                <div class="new-reservation-icon">
                    <i class="bi bi-plus-circle fs-1 text-white"></i>
                </div>
                <h5>Reservar una Cancha</h5>
                <p>Buscá y reservá canchas disponibles en tu zona</p>
            </div>
        </a>

        <!-- ==== MENSAJES DE FEEDBACK ==== -->
        <c:if test="${param.exito == 'reserva_cancelada'}">
            <div class="alert alert-success d-flex align-items-center mb-3">
                <i class="bi bi-check-circle-fill me-2"></i>
                <span>La reserva ha sido cancelada exitosamente.</span>
            </div>
        </c:if>
        <c:if test="${param.exito == 'equipo_abandonado'}">
            <div class="alert alert-success d-flex align-items-center mb-3">
                <i class="bi bi-check-circle-fill me-2"></i>
                <span>Has abandonado el equipo correctamente.</span>
            </div>
        </c:if>
        <c:if test="${param.exito == 'reserva_publicada'}">
            <div class="alert alert-success d-flex align-items-center mb-3">
                <i class="bi bi-check-circle-fill me-2"></i>
                <span>La reserva ha sido marcada como pública.</span>
            </div>
        </c:if>
        <c:if test="${param.exito == 'reserva_privatizada'}">
            <div class="alert alert-success d-flex align-items-center mb-3">
                <i class="bi bi-check-circle-fill me-2"></i>
                <span>La reserva ha sido marcada como privada.</span>
            </div>
        </c:if>
        <c:if test="${param.error != null}">
            <div class="alert alert-danger d-flex align-items-center mb-3">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <span>
                    <c:choose>
                        <c:when test="${param.error == 'cancelacion_no_autorizada'}">No tienes permiso para cancelar esta reserva.</c:when>
                        <c:when test="${param.error == 'abandono_no_autorizado'}">No puedes abandonar una reserva que tú creaste. Debes cancelarla.</c:when>
                        <c:when test="${param.error == 'fuera_de_tiempo'}">La reserva no se puede cancelar con menos de 1 hora de antelación.</c:when>
                        <c:when test="${param.error == 'toggle_no_autorizado'}">No tienes permiso para cambiar la visibilidad de esta reserva.</c:when>
                        <c:otherwise>Ocurrió un error al procesar tu solicitud.</c:otherwise>
                    </c:choose>
                </span>
            </div>
        </c:if>

        <!-- ==== SECCIÓN: RESERVAS ACTIVAS ==== -->
        <h5 class="fw-bold text-dark mb-3">Reservas Activas</h5>

        <!-- Sin reservas -->
        <c:if test="${empty misReservas}">
            <div class="empty-state">
                <i class="bi bi-calendar-x empty-state-icon"></i>
                <h5>No hay reservas activas</h5>
                <p>¡Reservá tu primera cancha!</p>
            </div>
        </c:if>

        <!-- Lista de reservas -->
        <c:forEach items="${misReservas}" var="reserva">
            <c:set var="esAnfitrion" value="${reserva.idUsuarioReserva.idUsuario == sessionScope.usuarioLogueado.idUsuario}" />
            
            <div class="reservation-card">
                <!-- Header -->
                <div class="reservation-header">
                    <div class="d-flex align-items-center">
                        <div class="complex-icon me-3">
                            <i class="bi bi-trophy-fill"></i>
                        </div>
                        <div class="flex-grow-1">
                            <h6 class="mb-0 fw-bold">${reserva.canchaidCancha.idComplejo.nombre}</h6>
                            <small class="opacity-90">Cancha N°${reserva.canchaidCancha.numero} • ${reserva.canchaidCancha.idDeporte.nombre}</small>
                        </div>
                        <c:if test="${!esAnfitrion}">
                            <span class="reservation-badge">
                                <i class="bi bi-person"></i> Invitado
                            </span>
                        </c:if>
                    </div>
                </div>

                <!-- Body -->
                <div class="reservation-body">
                    <div class="row">
                        <div class="col-md-8">
                            <!-- Fecha -->
                            <div class="info-row">
                                <i class="bi bi-calendar-event-fill"></i>
                                <strong>
                                    <fmt:formatDate value="${reserva.fechaHoraInicio}" pattern="EEEE, d 'de' MMMM 'de' yyyy"/>
                                </strong>
                            </div>

                            <!-- Hora -->
                            <div class="info-row">
                                <i class="bi bi-clock-fill"></i>
                                <span>
                                    <fmt:formatDate value="${reserva.fechaHoraInicio}" pattern="HH:mm"/> hs
                                </span>
                            </div>

                            <!-- Estado -->
                            <div class="mt-2">
                                <span class="badge-upcoming">
                                    <i class="bi bi-check-circle-fill"></i>
                                    Próxima
                                </span>
                                <c:if test="${reserva.esPublica}">
                                    <span class="badge-guest ms-2">
                                        <i class="bi bi-eye-fill"></i>
                                        Pública
                                    </span>
                                </c:if>
                            </div>
                        </div>

                        <!-- Acciones -->
                        <div class="col-md-4 mt-3 mt-md-0">
                            <div class="reservation-actions d-flex flex-column gap-2">
                                <c:choose>
                                    <c:when test="${esAnfitrion}">
                                        <!-- Botón Armar Equipo -->
                                        <a href="${pageContext.request.contextPath}/EquipoServlet?action=verEquipo&idReserva=${reserva.idReserva}" 
                                           class="btn btn-action btn-team">
                                            <i class="bi bi-people-fill me-2"></i>
                                            Armar Equipo
                                        </a>

                                        <!-- Botón Cancelar -->
                                        <button type="button" 
                                                class="btn btn-action btn-cancel"
                                                data-bs-toggle="modal" 
                                                data-bs-target="#cancelarReservaModal"
                                                data-id-reserva="${reserva.idReserva}">
                                            <i class="bi bi-x-circle me-2"></i>
                                            Cancelar Reserva
                                        </button>

                                        <!-- Botón Público/Privado -->
                                        <button type="button" 
                                                class="btn btn-action btn-outline-secondary btn-sm"
                                                data-bs-toggle="modal" 
                                                data-bs-target="#togglePublicaModal"
                                                data-id-reserva="${reserva.idReserva}"
                                                data-make-public="${!reserva.esPublica}"
                                                data-reserva-publica="${reserva.esPublica}">
                                            <c:choose>
                                                <c:when test="${reserva.esPublica}">
                                                    <i class="bi bi-eye-slash me-1"></i> Hacer Privada
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-eye me-1"></i> Hacer Pública
                                                </c:otherwise>
                                            </c:choose>
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Botón Ver Equipo -->
                                        <a href="${pageContext.request.contextPath}/EquipoServlet?action=verEquipo&idReserva=${reserva.idReserva}" 
                                           class="btn btn-action btn-outline-secondary">
                                            <i class="bi bi-eye me-2"></i>
                                            Ver Equipo
                                        </a>

                                        <!-- Botón Abandonar -->
                                        <button type="button" 
                                                class="btn btn-action btn-leave"
                                                data-bs-toggle="modal" 
                                                data-bs-target="#abandonarEquipoModal"
                                                data-id-reserva="${reserva.idReserva}">
                                            <i class="bi bi-door-open me-2"></i>
                                            Abandonar Equipo
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </main>

    <!-- ==== MODAL: CANCELAR RESERVA ==== -->
    <div class="modal fade" id="cancelarReservaModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <h5 class="modal-title fw-bold">
                        <i class="bi bi-exclamation-triangle-fill text-danger me-2"></i>
                        Confirmar Cancelación
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>¿Estás seguro de que quieres cancelar esta reserva? Se notificará a todos los jugadores. Esta acción no se puede deshacer.</p>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="border-radius: 8px;">
                        No, volver
                    </button>
                    <form action="ReservaServlet" method="POST" class="d-inline">
                        <input type="hidden" name="action" value="cancelar">
                        <input type="hidden" name="idReserva" id="idReservaParaCancelar" value="">
                        <button type="submit" class="btn btn-danger" style="border-radius: 8px;">
                            <i class="bi bi-trash me-2"></i>
                            Sí, cancelar reserva
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- ==== MODAL: ABANDONAR EQUIPO ==== -->
    <div class="modal fade" id="abandonarEquipoModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <h5 class="modal-title fw-bold">
                        <i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>
                        Confirmar Abandono
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>¿Estás seguro de que quieres abandonar este equipo?</p>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="border-radius: 8px;">
                        No, quedarme
                    </button>
                    <form action="EquipoServlet" method="POST" class="d-inline">
                        <input type="hidden" name="action" value="abandonarEquipo">
                        <input type="hidden" name="idReserva" id="idReservaParaAbandonar" value="">
                        <button type="submit" class="btn btn-warning" style="border-radius: 8px;">
                            <i class="bi bi-door-open me-2"></i>
                            Sí, abandonar
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- ==== MODAL: CAMBIAR VISIBILIDAD ==== -->
    <div class="modal fade" id="togglePublicaModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <h5 class="modal-title fw-bold" id="togglePublicaModalTitle">
                        <i class="bi bi-question-circle-fill text-info me-2"></i>
                        Confirmar Visibilidad
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="togglePublicaModalBody">
                    <!-- Contenido dinámico -->
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="border-radius: 8px;">
                        Cancelar
                    </button>
                    <form action="ReservaServlet" method="POST" class="d-inline">
                        <input type="hidden" name="action" value="togglePublica">
                        <input type="hidden" name="idReserva" id="idReservaParaToggle" value="">
                        <input type="hidden" name="makePublic" id="makePublicParaToggle" value="">
                        <button type="submit" class="btn btn-info" id="confirmTogglePublicaBtn" style="border-radius: 8px;">
                            Confirmar
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%-- Incluir la barra de navegación inferior --%>
    <c:set var="activePage" value="reservas" scope="request"/>
    <jsp:include page="/vistas/navbar.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Modal de cancelar
        var cancelarModal = document.getElementById('cancelarReservaModal');
        if (cancelarModal) {
            cancelarModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget;
                var idReserva = button.getAttribute('data-id-reserva');
                cancelarModal.querySelector('#idReservaParaCancelar').value = idReserva;
            });
        }

        // Modal de abandonar
        var abandonarModal = document.getElementById('abandonarEquipoModal');
        if (abandonarModal) {
            abandonarModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget;
                var idReserva = button.getAttribute('data-id-reserva');
                abandonarModal.querySelector('#idReservaParaAbandonar').value = idReserva;
            });
        }

        // Modal de visibilidad
        var togglePublicaModal = document.getElementById('togglePublicaModal');
        if (togglePublicaModal) {
            togglePublicaModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget;
                var idReserva = button.getAttribute('data-id-reserva');
                var makePublic = button.getAttribute('data-make-public');

                togglePublicaModal.querySelector('#idReservaParaToggle').value = idReserva;
                togglePublicaModal.querySelector('#makePublicParaToggle').value = makePublic;

                var modalTitle = togglePublicaModal.querySelector('#togglePublicaModalTitle');
                var modalBody = togglePublicaModal.querySelector('#togglePublicaModalBody');

                if (makePublic === 'true') {
                    modalTitle.innerHTML = '<i class="bi bi-question-circle-fill text-info me-2"></i> Confirmar Publicación';
                    modalBody.innerHTML = '<p>¿Estás seguro de que quieres hacer esta reserva <strong>pública</strong>? Aparecerá en la sección de Comunidad para que otros jugadores puedan unirse.</p>';
                } else {
                    modalTitle.innerHTML = '<i class="bi bi-question-circle-fill text-info me-2"></i> Confirmar Privatización';
                    modalBody.innerHTML = '<p>¿Estás seguro de que quieres hacer esta reserva <strong>privada</strong>? Ya no aparecerá en la sección de Comunidad.</p>';
                }
            });
        }
    </script>
</body>
</html>