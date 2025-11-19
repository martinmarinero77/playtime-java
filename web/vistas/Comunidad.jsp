<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Comunidad - PlayTime</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    
    <style>
        :root {
            --primary-blue: #2563eb;
            --primary-blue-dark: #1e40af;
            --success-green: #10b981;
            --purple-accent: #8b5cf6;
            --orange-accent: #f97316;
        }

        body {
            background-color: #f9fafb;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            padding-bottom: 80px;
        }

        /* ==== HEADER CON GRADIENTE ==== */
        .main-header {
            background: linear-gradient(90deg, var(--purple-accent) 0%, var(--primary-blue) 100%);
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

        /* ==== SECCIÓN DE CARDS ==== */
        .section-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 1.5rem;
            transition: all 0.2s;
        }

        .section-card:hover {
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.12);
        }

        .section-header {
            padding: 1.25rem;
            border-bottom: 1px solid #e5e7eb;
        }

        .section-header-invitations {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            color: white;
            border-bottom: none;
        }

        .section-header-public {
            background: linear-gradient(135deg, var(--success-green) 0%, #059669 100%);
            color: white;
            border-bottom: none;
        }

        .section-title {
            font-size: 1.125rem;
            font-weight: bold;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .section-body {
            padding: 1.25rem;
        }

        /* ==== TARJETAS DE INVITACIÓN ==== */
        .invitation-card {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 1.25rem;
            margin-bottom: 1rem;
            transition: all 0.2s;
        }

        .invitation-card:hover {
            border-color: var(--orange-accent);
            box-shadow: 0 4px 12px rgba(249, 115, 22, 0.15);
            transform: translateY(-2px);
        }

        .invitation-header {
            display: flex;
            align-items: start;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .invitation-icon {
            width: 48px;
            height: 48px;
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.25rem;
            flex-shrink: 0;
        }

        .invitation-title {
            font-weight: bold;
            color: #1f2937;
            margin-bottom: 0.25rem;
        }

        .invitation-date {
            color: #6b7280;
            font-size: 0.875rem;
        }

        .invitation-details {
            background: #f9fafb;
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1rem;
        }

        .detail-row {
            display: flex;
            align-items: start;
            gap: 0.5rem;
            margin-bottom: 0.5rem;
            color: #374151;
            font-size: 0.9375rem;
        }

        .detail-row:last-child {
            margin-bottom: 0;
        }

        .detail-row i {
            color: var(--orange-accent);
            margin-top: 0.125rem;
            flex-shrink: 0;
        }

        /* ==== TARJETAS DE RESERVA PÚBLICA ==== */
        .public-reservation-card {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 1.25rem;
            margin-bottom: 1rem;
            transition: all 0.2s;
        }

        .public-reservation-card:hover {
            border-color: var(--success-green);
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.15);
            transform: translateY(-2px);
        }

        .reservation-icon {
            width: 48px;
            height: 48px;
            background: linear-gradient(135deg, var(--success-green) 0%, #059669 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.25rem;
            flex-shrink: 0;
        }

        /* ==== BOTONES ==== */
        .btn-action {
            border-radius: 8px;
            font-weight: 500;
            padding: 0.5rem 1.25rem;
            transition: all 0.2s;
            font-size: 0.9375rem;
        }

        .btn-accept {
            background: var(--success-green);
            color: white;
            border: none;
        }

        .btn-accept:hover {
            background: #059669;
            transform: translateY(-1px);
            color: white;
        }

        .btn-reject {
            background: rgba(239, 68, 68, 0.1);
            color: #dc2626;
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .btn-reject:hover {
            background: rgba(239, 68, 68, 0.2);
            border-color: rgba(239, 68, 68, 0.5);
        }

        .btn-join {
            background: var(--success-green);
            color: white;
            border: none;
        }

        .btn-join:hover {
            background: #059669;
            transform: translateY(-1px);
            color: white;
        }

        /* ==== ALERTAS ==== */
        .alert {
            border-radius: 12px;
            border: none;
            padding: 1rem 1.25rem;
            margin-bottom: 1rem;
        }

        .alert-success {
            background-color: #d1fae5;
            color: #065f46;
        }

        .alert-danger {
            background-color: #fee2e2;
            color: #991b1b;
        }

        .alert-warning {
            background-color: #fef3c7;
            color: #92400e;
        }

        .alert-info {
            background-color: #dbeafe;
            color: #1e40af;
        }

        /* ==== EMPTY STATE ==== */
        .empty-state {
            background: #f9fafb;
            border-radius: 12px;
            padding: 3rem 2rem;
            text-align: center;
        }

        .empty-state-icon {
            font-size: 4rem;
            color: #d1d5db;
            margin-bottom: 1rem;
        }

        .empty-state h5 {
            font-weight: bold;
            color: #1f2937;
            margin-bottom: 0.5rem;
        }

        .empty-state p {
            color: #6b7280;
            margin: 0;
        }

        /* ==== BADGES ==== */
        .badge-sport {
            background: rgba(139, 92, 246, 0.1);
            color: #6d28d9;
            padding: 0.25rem 0.75rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        /* ==== RESPONSIVE ==== */
        @media (max-width: 768px) {
            .invitation-actions,
            .reservation-actions {
                display: flex;
                flex-direction: column;
                gap: 0.5rem;
            }

            .btn-action {
                width: 100%;
            }

            .invitation-header {
                flex-direction: column;
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
                    <h1 class="h4 mb-0 fw-bold">Comunidad</h1>
                    <p class="mb-0 small opacity-75">Conectá con otros jugadores</p>
                </div>
                <div class="header-icon">
                    <i class="bi bi-people-fill fs-4"></i>
                </div>
            </div>
        </div>
    </header>

    <!-- ==== CONTENIDO PRINCIPAL ==== -->
    <main class="container py-4">

        <!-- ==== SECCIÓN: INVITACIONES PENDIENTES ==== -->
        <div class="section-card">
            <div class="section-header section-header-invitations">
                <h2 class="section-title">
                    <i class="bi bi-envelope-paper-heart"></i>
                    Mis Invitaciones Pendientes
                </h2>
            </div>
            <div class="section-body">
                
                <!-- Mensajes de feedback -->
                <c:if test="${param.exito == 'RespuestaEnviada'}">
                    <div class="alert alert-success d-flex align-items-center">
                        <i class="bi bi-check-circle-fill me-2"></i>
                        <span>Tu respuesta ha sido registrada exitosamente.</span>
                    </div>
                </c:if>
                <c:if test="${param.error == 'InvitacionNoEncontrada'}">
                    <div class="alert alert-danger d-flex align-items-center">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        <span>La invitación ya no es válida o fue cancelada.</span>
                    </div>
                </c:if>

                <!-- Sin invitaciones -->
                <c:if test="${empty invitaciones}">
                    <div class="empty-state">
                        <i class="bi bi-envelope-open empty-state-icon"></i>
                        <h5>¡Todo al día!</h5>
                        <p>No tienes ninguna invitación pendiente en este momento.</p>
                    </div>
                </c:if>

                <!-- Lista de invitaciones -->
                <c:forEach items="${invitaciones}" var="invitacion">
                    <div class="invitation-card">
                        <div class="invitation-header">
                            <div class="invitation-icon">
                                <i class="bi bi-trophy-fill"></i>
                            </div>
                            <div class="flex-grow-1">
                                <h5 class="invitation-title">
                                    Partido de ${invitacion.reserva.canchaidCancha.idDeporte.nombre}
                                </h5>
                                <div class="invitation-date">
                                    <fmt:formatDate value="${invitacion.reserva.fechaHoraInicio}" type="date" dateStyle="medium"/>
                                </div>
                            </div>
                            <span class="badge-sport">
                                ${invitacion.reserva.canchaidCancha.idDeporte.nombre}
                            </span>
                        </div>

                        <div class="invitation-details">
                            <div class="detail-row">
                                <i class="bi bi-calendar-event-fill"></i>
                                <div>
                                    <strong>Cuándo:</strong> 
                                    <fmt:formatDate value="${invitacion.reserva.fechaHoraInicio}" pattern="EEEE d 'de' MMMM 'a las' HH:mm"/> hs
                                </div>
                            </div>
                            <div class="detail-row">
                                <i class="bi bi-geo-alt-fill"></i>
                                <div>
                                    <strong>Dónde:</strong> 
                                    Cancha N°${invitacion.reserva.canchaidCancha.numero} en ${invitacion.reserva.canchaidCancha.idComplejo.nombre}
                                </div>
                            </div>
                            <div class="detail-row">
                                <i class="bi bi-person-fill"></i>
                                <div>
                                    <strong>Organiza:</strong> 
                                    ${invitacion.reserva.idUsuarioReserva.nombre} ${invitacion.reserva.idUsuarioReserva.apellido}
                                </div>
                            </div>
                        </div>

                        <form action="EquipoServlet" method="POST">
                            <input type="hidden" name="action" value="responderInvitacion">
                            <input type="hidden" name="idReserva" value="${invitacion.reserva.idReserva}">
                            <div class="invitation-actions d-flex gap-2">
                                <button type="submit" name="respuesta" value="aceptar" class="btn btn-action btn-accept flex-grow-1">
                                    <i class="bi bi-check-lg me-2"></i>
                                    Aceptar
                                </button>
                                <button type="submit" name="respuesta" value="rechazar" class="btn btn-action btn-reject flex-grow-1">
                                    <i class="bi bi-x-lg me-2"></i>
                                    Rechazar
                                </button>
                            </div>
                        </form>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- ==== SECCIÓN: RESERVAS PÚBLICAS ==== -->
        <div class="section-card">
            <div class="section-header section-header-public">
                <h2 class="section-title">
                    <i class="bi bi-globe"></i>
                    Reservas Públicas
                </h2>
            </div>
            <div class="section-body">

                <!-- Mensajes de feedback -->
                <c:if test="${param.exito == 'unido_a_reserva'}">
                    <div class="alert alert-success d-flex align-items-center">
                        <i class="bi bi-check-circle-fill me-2"></i>
                        <span>¡Te has unido a la reserva correctamente!</span>
                    </div>
                </c:if>
                <c:if test="${param.error == 'ya_eres_miembro'}">
                    <div class="alert alert-warning d-flex align-items-center">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        <span>Ya eres miembro de esta reserva.</span>
                    </div>
                </c:if>
                <c:if test="${param.error == 'unirse_fallido'}">
                    <div class="alert alert-danger d-flex align-items-center">
                        <i class="bi bi-x-circle-fill me-2"></i>
                        <span>No se pudo unir a la reserva. Intenta de nuevo.</span>
                    </div>
                </c:if>

                <!-- Sin reservas públicas -->
                <c:if test="${empty reservasPublicas}">
                    <div class="empty-state">
                        <i class="bi bi-calendar-x empty-state-icon"></i>
                        <h5>No hay reservas públicas disponibles</h5>
                        <p>¡Sé el primero en hacer una pública!</p>
                    </div>
                </c:if>

                <!-- Lista de reservas públicas -->
                <c:forEach items="${reservasPublicas}" var="reservaDto">
                    <div class="public-reservation-card">
                        <div class="invitation-header">
                            <div class="reservation-icon">
                                <i class="bi bi-trophy-fill"></i>
                            </div>
                            <div class="flex-grow-1">
                                <h5 class="invitation-title">
                                    ${reservaDto.reserva.canchaidCancha.idDeporte.nombre} en ${reservaDto.reserva.canchaidCancha.idComplejo.nombre}
                                </h5>
                                <div class="invitation-date">
                                    <fmt:formatDate value="${reservaDto.reserva.fechaHoraInicio}" type="date" dateStyle="medium"/>
                                </div>
                            </div>
                            <span class="badge-sport">
                                ${reservaDto.reserva.canchaidCancha.idDeporte.nombre}
                            </span>
                        </div>

                        <div class="invitation-details">
                            <div class="detail-row">
                                <i class="bi bi-calendar-event-fill"></i>
                                <div>
                                    <strong>Cuándo:</strong> 
                                    <fmt:formatDate value="${reservaDto.reserva.fechaHoraInicio}" pattern="EEEE d 'de' MMMM 'a las' HH:mm"/> hs
                                </div>
                            </div>
                            <div class="detail-row">
                                <i class="bi bi-geo-alt-fill"></i>
                                <div>
                                    <strong>Cancha:</strong> 
                                    N°${reservaDto.reserva.canchaidCancha.numero}
                                </div>
                            </div>
                            <div class="detail-row">
                                <i class="bi bi-person-fill"></i>
                                <div>
                                    <strong>Organiza:</strong> 
                                    ${reservaDto.reserva.idUsuarioReserva.nombre} ${reservaDto.reserva.idUsuarioReserva.apellido}
                                </div>
                            </div>
                            <div class="detail-row">
                                <i class="bi bi-people-fill"></i>
                                <div>
                                    <strong>Jugadores:</strong> 
                                    ${reservaDto.jugadoresAceptados} / ${reservaDto.reserva.canchaidCancha.capacidad * 2}
                                </div>
                            </div>
                        </div>

                        <form action="EquipoServlet" method="POST">
                            <input type="hidden" name="action" value="unirseAReservaPublica">
                            <input type="hidden" name="idReserva" value="${reservaDto.reserva.idReserva}">
                            <button type="submit" class="btn btn-action btn-join w-100">
                                <i class="bi bi-person-plus me-2"></i>
                                Unirse al Partido
                            </button>
                        </form>
                    </div>
                </c:forEach>
            </div>
        </div>
    </main>

    <%-- Incluir la barra de navegación, indicando que 'comunidad' es la página activa --%>
    <c:set var="activePage" value="comunidad" scope="request"/>
    <jsp:include page="/vistas/navbar.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>