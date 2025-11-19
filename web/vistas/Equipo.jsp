<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrar Equipo - PlayTime</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-blue: #2563eb;
            --primary-blue-dark: #1e40af;
            --team-light: #3b82f6;
            --team-dark: #1f2937;
        }

        body {
            background-color: #f9fafb;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        }

        /* ==== HEADER CON GRADIENTE ==== */
        .main-header {
            background: linear-gradient(90deg, var(--primary-blue) 0%, var(--primary-blue-dark) 100%);
            color: white;
            padding: 1rem 0;
        }

        .btn-back {
            width: 40px;
            height: 40px;
            background-color: rgba(255, 255, 255, 0.2);
            border: none;
            border-radius: 50%;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background-color 0.2s;
        }

        .btn-back:hover {
            background-color: rgba(255, 255, 255, 0.3);
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

        /* ==== CARDS DE RESUMEN ==== */
        .summary-card {
            background: white;
            border-radius: 16px;
            padding: 1.25rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .summary-icon {
            width: 56px;
            height: 56px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 0.75rem;
        }

        .summary-count {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 0.25rem;
        }

        .summary-label {
            font-size: 0.875rem;
            color: #6b7280;
            font-weight: 500;
        }

        /* ==== SECCIONES DE EQUIPOS ==== */
        .team-section {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            margin-bottom: 1rem;
        }

        .team-header {
            padding: 1rem 1.25rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .team-header.light {
            background: linear-gradient(135deg, #60a5fa 0%, #3b82f6 100%);
        }

        .team-header.dark {
            background: linear-gradient(135deg, #4b5563 0%, #1f2937 100%);
        }

        .team-header.none {
            background: linear-gradient(135deg, #fb923c 0%, #ea580c 100%);
        }

        .team-title {
            color: white;
            font-weight: bold;
            font-size: 1.125rem;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .team-badge {
            background: white;
            color: inherit;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-weight: bold;
            font-size: 0.875rem;
        }

        .team-body {
            padding: 0.75rem;
        }

        /* ==== CARDS DE JUGADORES ==== */
        .player-card {
            background: #f9fafb;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 0.75rem 1rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            transition: all 0.2s;
        }

        .player-card:hover {
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transform: translateY(-1px);
        }

        .player-info {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .player-avatar {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1.125rem;
            color: white;
        }

        .player-avatar.light { background: var(--team-light); }
        .player-avatar.dark { background: var(--team-dark); }
        .player-avatar.none { background: #ea580c; }

        .player-name {
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 0.125rem;
        }

        .player-nickname {
            font-size: 0.875rem;
            color: #6b7280;
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }

        .player-actions {
            display: flex;
            gap: 0.5rem;
        }

        .btn-move {
            padding: 0.375rem 0.75rem;
            border-radius: 8px;
            border: none;
            font-size: 0.875rem;
            font-weight: 500;
            transition: all 0.2s;
        }

        .btn-move-light {
            background: rgba(59, 130, 246, 0.1);
            color: #1e40af;
        }

        .btn-move-light:hover {
            background: rgba(59, 130, 246, 0.2);
        }

        .btn-move-dark {
            background: rgba(31, 41, 55, 0.1);
            color: #1f2937;
        }

        .btn-move-dark:hover {
            background: rgba(31, 41, 55, 0.2);
        }

        .btn-remove {
            background: rgba(239, 68, 68, 0.1);
            color: #dc2626;
            border: none;
            padding: 0.375rem 0.75rem;
            border-radius: 8px;
            transition: all 0.2s;
        }

        .btn-remove:hover {
            background: rgba(239, 68, 68, 0.2);
        }

        /* ==== SECCIÓN INVITAR ==== */
        .invite-section {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            margin-bottom: 1.5rem;
        }

        .invite-section h5 {
            font-weight: bold;
            color: #1f2937;
            margin-bottom: 1rem;
        }

        .invite-input-group {
            display: flex;
            gap: 0.75rem;
        }

        .invite-input {
            flex: 1;
            border: 1px solid #d1d5db;
            border-radius: 12px;
            padding: 0.75rem 1rem;
            font-size: 0.9375rem;
        }

        .invite-input:focus {
            border-color: var(--primary-blue);
            outline: none;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .btn-invite {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
            border: none;
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
            transition: all 0.2s;
        }

        .btn-invite:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(16, 185, 129, 0.4);
        }

        /* ==== LISTA DE INVITACIONES ==== */
        .invitations-list {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .invitation-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            margin-bottom: 0.75rem;
            transition: all 0.2s;
        }

        .invitation-item:hover {
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .invitation-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .invitation-avatar {
            width: 48px;
            height: 48px;
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--primary-blue-dark) 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1.25rem;
        }

        .invitation-details h6 {
            margin: 0 0 0.25rem 0;
            font-weight: 600;
            color: #1f2937;
        }

        .invitation-details small {
            color: #6b7280;
        }

        .status-badge {
            padding: 0.375rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8125rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.375rem;
        }

        .status-pending {
            background: #fef3c7;
            color: #92400e;
        }

        .status-accepted {
            background: #d1fae5;
            color: #065f46;
        }

        .status-rejected {
            background: #fee2e2;
            color: #991b1b;
        }

        .badge-host {
            background: var(--primary-blue);
            color: white;
            padding: 0.25rem 0.5rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
            margin-left: 0.5rem;
        }

        /* ==== EMPTY STATE ==== */
        .empty-state {
            text-align: center;
            padding: 2rem;
            color: #9ca3af;
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        /* ==== ALERTAS ==== */
        .alert {
            border-radius: 12px;
            border: none;
            padding: 1rem 1.25rem;
        }

        /* ==== RESPONSIVE ==== */
        @media (max-width: 768px) {
            .invite-input-group {
                flex-direction: column;
            }

            .player-actions {
                flex-direction: column;
                gap: 0.25rem;
            }

            .invitation-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.75rem;
            }
        }
    </style>
</head>
<body>

    <!-- ==== HEADER CON GRADIENTE ==== -->
    <header class="main-header">
        <div class="container">
            <div class="d-flex align-items-center">
                <a href="${pageContext.request.contextPath}/reservas?action=mis_reservas" class="btn-back me-3">
                    <i class="bi bi-arrow-left fs-5"></i>
                </a>
                <div class="flex-grow-1">
                    <h1 class="h4 mb-0 fw-bold">Armar Equipos</h1>
                    <p class="mb-0 small opacity-75">Organizá los jugadores por camiseta</p>
                </div>
                <div class="header-icon">
                    <i class="bi bi-people fs-4"></i>
                </div>
            </div>
        </div>
    </header>

    <!-- ==== CONTENIDO PRINCIPAL ==== -->
    <main class="container py-4">

        <!-- Info de la Reserva -->
        <c:if test="${not empty reserva}">
            <div class="alert alert-info mb-4">
                <i class="bi bi-info-circle me-2"></i>
                <strong>Reserva:</strong> 
                <fmt:formatDate value="${reserva.fechaHoraInicio}" pattern="dd/MM/yyyy"/> a las 
                <fmt:formatDate value="${reserva.fechaHoraInicio}" pattern="HH:mm"/> hs
                • Cancha N° ${reserva.canchaidCancha.numero} en ${reserva.canchaidCancha.idComplejo.nombre}
            </div>
        </c:if>

        <!-- Variables de permisos -->
        <c:set var="esAnfitrion" value="${reserva.idUsuarioReserva.idUsuario == sessionScope.usuarioLogueado.idUsuario}" />
        <c:set var="esParticipanteAceptado" value="${false}" />
        <c:forEach items="${jugadores}" var="jugador">
            <c:if test="${jugador.usuario.idUsuario == sessionScope.usuarioLogueado.idUsuario && jugador.estadoInvitacion == 'ACEPTADA'}">
                <c:set var="esParticipanteAceptado" value="${true}" />
            </c:if>
        </c:forEach>

        <!-- ==== CARDS DE RESUMEN ==== -->
        <div class="row g-3 mb-4">
            <div class="col-6 col-md-4">
                <div class="summary-card">
                    <div class="summary-icon" style="background: rgba(59, 130, 246, 0.1);">
                        <i class="bi bi-shield-fill fs-3" style="color: #3b82f6;"></i>
                    </div>
                    <div class="summary-count" style="color: #3b82f6;">
                        <c:set var="countLight" value="0"/>
                        <c:forEach items="${jugadores}" var="j">
                            <c:if test="${j.estadoInvitacion == 'ACEPTADA' && j.camiseta == 'CLARA'}">
                                <c:set var="countLight" value="${countLight + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${countLight}
                    </div>
                    <div class="summary-label">Claros</div>
                </div>
            </div>
            <div class="col-6 col-md-4">
                <div class="summary-card">
                    <div class="summary-icon" style="background: rgba(31, 41, 55, 0.1);">
                        <i class="bi bi-shield-fill fs-3" style="color: #1f2937;"></i>
                    </div>
                    <div class="summary-count" style="color: #1f2937;">
                        <c:set var="countDark" value="0"/>
                        <c:forEach items="${jugadores}" var="j">
                            <c:if test="${j.estadoInvitacion == 'ACEPTADA' && j.camiseta == 'OSCURA'}">
                                <c:set var="countDark" value="${countDark + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${countDark}
                    </div>
                    <div class="summary-label">Oscuros</div>
                </div>
            </div>
            <div class="col-12 col-md-4">
                <div class="summary-card">
                    <div class="summary-icon" style="background: rgba(234, 88, 12, 0.1);">
                        <i class="bi bi-question-circle-fill fs-3" style="color: #ea580c;"></i>
                    </div>
                    <div class="summary-count" style="color: #ea580c;">
                        <c:set var="countNone" value="0"/>
                        <c:forEach items="${jugadores}" var="j">
                            <c:if test="${j.estadoInvitacion == 'ACEPTADA' && j.camiseta == 'NINGUNO'}">
                                <c:set var="countNone" value="${countNone + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${countNone}
                    </div>
                    <div class="summary-label">Sin Equipo</div>
                </div>
            </div>
        </div>

        <!-- ==== SECCIÓN: SIN EQUIPO ==== -->
        <div class="team-section">
            <div class="team-header none">
                <h5 class="team-title">
                    <i class="bi bi-question-circle-fill"></i>
                    Sin Equipo Asignado
                </h5>
                <span class="team-badge" style="color: #ea580c;">${countNone}</span>
            </div>
            <div class="team-body">
                <c:set var="hasNone" value="${false}"/>
                <c:forEach items="${jugadores}" var="jugador">
                    <c:if test="${jugador.estadoInvitacion == 'ACEPTADA' && jugador.camiseta == 'NINGUNO'}">
                        <c:set var="hasNone" value="${true}"/>
                        <div class="player-card">
                            <div class="player-info">
                                <div class="player-avatar none">
                                    ${jugador.usuario.nombre.substring(0,1).toUpperCase()}
                                </div>
                                <div>
                                    <div class="player-name">${jugador.usuario.nombre} ${jugador.usuario.apellido}</div>
                                    <div class="player-nickname">
                                        <i class="bi bi-envelope-fill"></i>
                                        ${jugador.usuario.email}
                                    </div>
                                </div>
                            </div>
                            <div class="player-actions">
                                <form action="EquipoServlet" method="POST" class="d-inline">
                                    <input type="hidden" name="action" value="asignarCamiseta">
                                    <input type="hidden" name="idReserva" value="${reserva.idReserva}">
                                    <input type="hidden" name="idUsuario" value="${jugador.usuario.idUsuario}">
                                    <input type="hidden" name="camiseta" value="CLARA">
                                    <button type="submit" class="btn-move btn-move-light">
                                        <i class="bi bi-arrow-right"></i> Claro
                                    </button>
                                </form>
                                <form action="EquipoServlet" method="POST" class="d-inline">
                                    <input type="hidden" name="action" value="asignarCamiseta">
                                    <input type="hidden" name="idReserva" value="${reserva.idReserva}">
                                    <input type="hidden" name="idUsuario" value="${jugador.usuario.idUsuario}">
                                    <input type="hidden" name="camiseta" value="OSCURA">
                                    <button type="submit" class="btn-move btn-move-dark">
                                        <i class="bi bi-arrow-right"></i> Oscuro
                                    </button>
                                </form>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
                <c:if test="${!hasNone}">
                    <div class="empty-state">
                        <i class="bi bi-check-circle-fill"></i>
                        <p class="mb-0">Todos los jugadores tienen equipo asignado</p>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- ==== SECCIÓN: EQUIPO CLARO ==== -->
        <div class="team-section">
            <div class="team-header light">
                <h5 class="team-title">
                    <i class="bi bi-shield-fill"></i>
                    Equipo Claro
                </h5>
                <span class="team-badge" style="color: #3b82f6;">${countLight}</span>
            </div>
            <div class="team-body">
                <c:set var="hasLight" value="${false}"/>
                <c:forEach items="${jugadores}" var="jugador">
                    <c:if test="${jugador.estadoInvitacion == 'ACEPTADA' && jugador.camiseta == 'CLARA'}">
                        <c:set var="hasLight" value="${true}"/>
                        <div class="player-card">
                            <div class="player-info">
                                <div class="player-avatar light">
                                    ${jugador.usuario.nombre.substring(0,1).toUpperCase()}
                                </div>
                                <div>
                                    <div class="player-name">${jugador.usuario.nombre} ${jugador.usuario.apellido}</div>
                                    <div class="player-nickname">
                                        <i class="bi bi-envelope-fill"></i>
                                        ${jugador.usuario.email}
                                    </div>
                                </div>
                            </div>
                            <div class="player-actions">
                                <form action="EquipoServlet" method="POST" class="d-inline">
                                    <input type="hidden" name="action" value="asignarCamiseta">
                                    <input type="hidden" name="idReserva" value="${reserva.idReserva}">
                                    <input type="hidden" name="idUsuario" value="${jugador.usuario.idUsuario}">
                                    <input type="hidden" name="camiseta" value="OSCURA">
                                    <button type="submit" class="btn-move btn-move-dark">
                                        <i class="bi bi-arrow-right"></i>
                                    </button>
                                </form>
                                <c:if test="${esAnfitrion && jugador.usuario.idUsuario != sessionScope.usuarioLogueado.idUsuario}">
                                    <button type="button" 
                                            class="btn-remove"
                                            data-bs-toggle="modal" 
                                            data-bs-target="#eliminarJugadorModal"
                                            data-id-reserva="${reserva.idReserva}"
                                            data-id-usuario="${jugador.usuario.idUsuario}"
                                            data-nombre-jugador="${jugador.usuario.nombre} ${jugador.usuario.apellido}">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
                <c:if test="${!hasLight}">
                    <div class="empty-state">
                        <i class="bi bi-people"></i>
                        <p class="mb-0">No hay jugadores en este equipo</p>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- ==== SECCIÓN: EQUIPO OSCURO ==== -->
        <div class="team-section">
            <div class="team-header dark">
                <h5 class="team-title">
                    <i class="bi bi-shield-fill"></i>
                    Equipo Oscuro
                </h5>
                <span class="team-badge" style="color: #1f2937;">${countDark}</span>
            </div>
            <div class="team-body">
                <c:set var="hasDark" value="${false}"/>
                <c:forEach items="${jugadores}" var="jugador">
                    <c:if test="${jugador.estadoInvitacion == 'ACEPTADA' && jugador.camiseta == 'OSCURA'}">
                        <c:set var="hasDark" value="${true}"/>
                        <div class="player-card">
                            <div class="player-info">
                                <div class="player-avatar dark">
                                    ${jugador.usuario.nombre.substring(0,1).toUpperCase()}
                                </div>
                                <div>
                                    <div class="player-name">${jugador.usuario.nombre} ${jugador.usuario.apellido}</div>
                                    <div class="player-nickname">
                                        <i class="bi bi-envelope-fill"></i>
                                        ${jugador.usuario.email}
                                    </div>
                                </div>
                            </div>
                            <div class="player-actions">
                                <form action="EquipoServlet" method="POST" class="d-inline">
                                    <input type="hidden" name="action" value="asignarCamiseta">
                                    <input type="hidden" name="idReserva" value="${reserva.idReserva}">
                                    <input type="hidden" name="idUsuario" value="${jugador.usuario.idUsuario}">
                                    <input type="hidden" name="camiseta" value="CLARA">
                                    <button type="submit" class="btn-move btn-move-light">
                                        <i class="bi bi-arrow-left"></i>
                                    </button>
                                </form>
                                <c:if test="${esAnfitrion && jugador.usuario.idUsuario != sessionScope.usuarioLogueado.idUsuario}">
                                    <button type="button" 
                                            class="btn-remove"
                                            data-bs-toggle="modal" 
                                            data-bs-target="#eliminarJugadorModal"
                                            data-id-reserva="${reserva.idReserva}"
                                            data-id-usuario="${jugador.usuario.idUsuario}"
                                            data-nombre-jugador="${jugador.usuario.nombre} ${jugador.usuario.apellido}">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
                <c:if test="${!hasDark}">
                    <div class="empty-state">
                        <i class="bi bi-people"></i>
                        <p class="mb-0">No hay jugadores en este equipo</p>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- ==== SECCIÓN: INVITAR JUGADOR ==== -->
        <c:if test="${esAnfitrion || esParticipanteAceptado}">
            <div class="invite-section">
                <h5>
                    <i class="bi bi-person-plus-fill me-2" style="color: var(--primary-blue);"></i>
                    Invitar Jugador
                </h5>

                <!-- Mensajes -->
                <c:if test="${param.error == 'UsuarioNoEncontrado'}">
                    <div class="alert alert-danger">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        El email ingresado no corresponde a un usuario registrado.
                    </div>
                </c:if>
                <c:if test="${param.error == 'InvitacionAUnoMismo'}">
                    <div class="alert alert-danger">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        No puedes invitarte a ti mismo.
                    </div>
                </c:if>
                <c:if test="${param.error == 'UsuarioYaInvitado'}">
                    <div class="alert alert-danger">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        Este usuario ya ha sido invitado o ya forma parte del equipo.
                    </div>
                </c:if>
                <c:if test="${param.exito == 'InvitacionEnviada'}">
                    <div class="alert alert-success">
                        <i class="bi bi-check-circle-fill me-2"></i>
                        ¡Invitación enviada correctamente!
                    </div>
                </c:if>

                <form action="EquipoServlet" method="POST">
                    <input type="hidden" name="action" value="invitarJugador">
                    <input type="hidden" name="idReserva" value="${reserva.idReserva}">
                    
                    <div class="invite-input-group">
                        <input type="email" 
                               class="invite-input" 
                               name="email" 
                               placeholder="jugador@email.com" 
                               required>
                        <button type="submit" class="btn-invite">
                            <i class="bi bi-send-fill me-2"></i>
                            Enviar Invitación
                        </button>
                    </div>
                </form>
            </div>
        </c:if>

        <!-- ==== LISTA DE INVITACIONES ==== -->
        <div class="invitations-list">
            <h5 class="mb-4">
                <i class="bi bi-list-check me-2" style="color: var(--primary-blue);"></i>
                Registro de Invitaciones
            </h5>

            <!-- Mensajes -->
            <c:if test="${param.exito == 'jugador_eliminado'}">
                <div class="alert alert-success">
                    <i class="bi bi-check-circle-fill me-2"></i>
                    Jugador eliminado correctamente.
                </div>
            </c:if>
            <c:if test="${param.error == 'eliminacion_no_autorizada'}">
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    No tienes permiso para eliminar a este jugador.
                </div>
            </c:if>

            <!-- Lista de jugadores -->
            <c:choose>
                <c:when test="${not empty jugadores}">
                    <c:forEach items="${jugadores}" var="jugador">
                        <div class="invitation-item">
                            <div class="invitation-info">
                                <div class="invitation-avatar">
                                    ${jugador.usuario.nombre.substring(0,1).toUpperCase()}
                                </div>
                                <div class="invitation-details">
                                    <h6>
                                        ${jugador.usuario.nombre} ${jugador.usuario.apellido}
                                        <c:if test="${jugador.usuario.idUsuario == reserva.idUsuarioReserva.idUsuario}">
                                            <span class="badge-host">
                                                <i class="bi bi-star-fill"></i> Anfitrión
                                            </span>
                                        </c:if>
                                    </h6>
                                    <small>
                                        <i class="bi bi-envelope me-1"></i>
                                        ${jugador.usuario.email}
                                    </small>
                                </div>
                            </div>
                            
                            <div class="d-flex align-items-center gap-2">
                                <c:choose>
                                    <c:when test="${jugador.estadoInvitacion == 'PENDIENTE'}">
                                        <span class="status-badge status-pending">
                                            <i class="bi bi-clock-history"></i>
                                            Pendiente
                                        </span>
                                    </c:when>
                                    <c:when test="${jugador.estadoInvitacion == 'ACEPTADA'}">
                                        <span class="status-badge status-accepted">
                                            <i class="bi bi-check-circle-fill"></i>
                                            Aceptada
                                        </span>
                                    </c:when>
                                    <c:when test="${jugador.estadoInvitacion == 'RECHAZADA'}">
                                        <span class="status-badge status-rejected">
                                            <i class="bi bi-x-circle-fill"></i>
                                            Rechazada
                                        </span>
                                    </c:when>
                                </c:choose>
                                
                                <c:if test="${esAnfitrion && jugador.usuario.idUsuario != sessionScope.usuarioLogueado.idUsuario}">
                                    <button type="button" 
                                            class="btn-remove"
                                            data-bs-toggle="modal" 
                                            data-bs-target="#eliminarJugadorModal"
                                            data-id-reserva="${reserva.idReserva}"
                                            data-id-usuario="${jugador.usuario.idUsuario}"
                                            data-nombre-jugador="${jugador.usuario.nombre} ${jugador.usuario.apellido}">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="bi bi-people-fill"></i>
                        <p class="mb-0">Aún no hay jugadores en el equipo</p>
                        <small class="text-muted">¡Invita a tus amigos!</small>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <!-- ==== MODAL: ELIMINAR JUGADOR ==== -->
    <div class="modal fade" id="eliminarJugadorModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="border-radius: 16px; border: none;">
                <div class="modal-header border-0">
                    <h5 class="modal-title fw-bold">
                        <i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>
                        Eliminar Jugador
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p class="mb-0">
                        ¿Estás seguro de que quieres eliminar a 
                        <strong id="nombreJugadorParaEliminar"></strong> del equipo?
                    </p>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="border-radius: 8px;">
                        Cancelar
                    </button>
                    <form action="EquipoServlet" method="POST" class="d-inline">
                        <input type="hidden" name="action" value="eliminarJugador">
                        <input type="hidden" name="idReserva" id="idReservaParaEliminar" value="">
                        <input type="hidden" name="idUsuario" id="idUsuarioParaEliminar" value="">
                        <button type="submit" class="btn btn-danger" style="border-radius: 8px;">
                            <i class="bi bi-trash me-2"></i>
                            Sí, eliminar
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Modal de eliminación
        var eliminarModal = document.getElementById('eliminarJugadorModal');
        if (eliminarModal) {
            eliminarModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget;
                var idReserva = button.getAttribute('data-id-reserva');
                var idUsuario = button.getAttribute('data-id-usuario');
                var nombreJugador = button.getAttribute('data-nombre-jugador');
                
                eliminarModal.querySelector('#idReservaParaEliminar').value = idReserva;
                eliminarModal.querySelector('#idUsuarioParaEliminar').value = idUsuario;
                eliminarModal.querySelector('#nombreJugadorParaEliminar').textContent = nombreJugador;
            });
        }
    </script>
</body>
</html>