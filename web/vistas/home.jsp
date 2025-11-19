<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Verificación de Seguridad --%>
<c:if test="${empty sessionScope.usuarioLogueado}">
    <c:redirect url="UsuarioServlet?action=mostrar_login" />
</c:if>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio - PlayTime</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    
    <style>
        /* ==== HEADER CON GRADIENTE ==== */
        .main-header {
            background: linear-gradient(90deg, var(--primary-blue) 0%, var(--primary-blue-dark) 100%);
            color: white;
            padding: 1rem 0;
        }

        .avatar-icon {
            width: 40px;
            height: 40px;
            background-color: rgba(96, 165, 250, 0.6);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            font-weight: bold;
        }

        .search-bar {
            background-color: white;
            border-radius: 12px;
            border: none;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            position: relative; /* Added for absolute positioning context */
        }

        .search-bar .form-control {
            border: none;
            box-shadow: none;
        }

        .search-bar .form-control:focus {
            box-shadow: none;
        }

        .search-bar .input-group-text {
            background-color: white;
            border: none;
            color: var(--primary-blue);
        }

        /* ==== ACCIONES RÁPIDAS ==== */
        .quick-action-card {
            border-radius: 16px;
            transition: transform 0.2s, box-shadow 0.2s;
            background-color: white;
            border: 1px solid #e5e7eb;
            cursor: pointer;
        }

        .quick-action-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
        }

        .quick-action-card .icon-container {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 12px;
        }

        .quick-action-card.blue .icon-container {
            background-color: rgba(37, 99, 235, 0.1);
            color: var(--primary-blue);
        }

        .quick-action-card.green .icon-container {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--success-green);
        }

        .quick-action-card.orange .icon-container {
            background-color: rgba(245, 158, 11, 0.1);
            color: var(--warning-orange);
        }

        .quick-action-card.purple .icon-container {
            background-color: rgba(139, 92, 246, 0.1);
            color: var(--purple);
        }

        .quick-action-card .action-text {
            font-size: 0.875rem;
            font-weight: 600;
            color: #374151;
        }

        /* ==== CANCHAS DESTACADAS ==== */
        .field-card {
            border-radius: 16px;
            border: 1px solid #e5e7eb;
            background-color: white;
            overflow: hidden;
            transition: transform 0.2s, box-shadow 0.2s;
            margin-bottom: 1rem;
        }

        .field-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
        }

        .field-card-header {
            background: linear-gradient(135deg, #34d399 0%, #10b981 100%);
            color: white;
            padding: 1rem;
        }

        .field-icon {
            width: 48px;
            height: 48px;
            background-color: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .sport-badge {
            background-color: rgba(59, 130, 246, 0.1);
            color: #1e40af;
            font-size: 0.75rem;
            padding: 4px 12px;
            border-radius: 12px;
            font-weight: 500;
        }

        .price-tag {
            font-size: 1.25rem;
            font-weight: bold;
            color: #374151;
        }

        .rating {
            color: #f59e0b;
            font-size: 0.875rem;
        }

        .availability-badge {
            background-color: rgba(16, 185, 129, 0.1);
            color: #065f46;
            font-size: 0.625rem;
            padding: 4px 8px;
            border-radius: 12px;
            font-weight: 500;
        }

        /* ==== PRÓXIMOS PARTIDOS ==== */
        .upcoming-match-card {
            border-radius: 16px;
            border: 1px solid #e5e7eb;
            background-color: white;
            padding: 1rem;
        }

        .match-status {
            background-color: rgba(16, 185, 129, 0.1);
            color: #065f46;
            font-size: 0.75rem;
            padding: 4px 12px;
            border-radius: 16px;
            font-weight: 600;
        }

        /* ==== UTILIDADES ==== */
        .section-title {
            font-size: 1.125rem;
            font-weight: bold;
            color: #1f2937;
            margin-bottom: 1rem;
        }

        .text-link {
            color: var(--primary-blue);
            font-size: 0.875rem;
            font-weight: 600;
            text-decoration: none;
        }

        .text-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <!-- ==== HEADER CON GRADIENTE ==== -->
    <header class="main-header">
        <div class="container">
            
            <!-- Fila Superior: Título y Avatar -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h1 class="h4 mb-0 fw-bold">SportReserva</h1>
                    <p class="mb-0 small opacity-75">¡Hola, ${sessionScope.usuarioLogueado.nombre}! ⚽</p>
                </div>
                <div class="avatar-icon">
                    <c:choose>
                        <c:when test="${not empty sessionScope.usuarioLogueado.nombre}">
                            ${sessionScope.usuarioLogueado.nombre.substring(0,1).toUpperCase()}
                        </c:when>
                        <c:otherwise>
                            <i class="bi bi-person-fill"></i>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Barra de Búsqueda -->
            <div class="search-bar">
                <div class="input-group">
                    <span class="input-group-text">
                        <i class="bi bi-search"></i>
                    </span>
                    <input type="text" class="form-control" id="homeSearchInput" placeholder="Buscar canchas, deportes o complejos...">
                    <span class="input-group-text">
                        <i class="bi bi-sliders"></i>
                    </span>
                </div>
                <div id="searchResults" class="list-group position-absolute w-100" style="z-index: 1000; max-height: 300px; overflow-y: auto; display: none;">
                    <!-- Resultados de la búsqueda AJAX se insertarán aquí -->
                </div>
            </div>
            
            <!-- Ubicación -->
            <div class="d-flex align-items-center mt-2 small opacity-75">
                <i class="bi bi-geo-alt-fill me-1"></i>
                <span>San Juan, Argentina</span>
            </div>
        </div>
    </header>

    <!-- ==== CONTENIDO PRINCIPAL ==== -->
    <main class="container py-4">

        <!-- ==== SECCIÓN: ACCIONES RÁPIDAS ==== -->
        <h2 class="section-title">Acciones Rápidas</h2>
        <div class="row g-3 mb-4">
            <!-- Acción 1: Reservar Cancha -->
            <div class="col-6">
                <a href="${pageContext.request.contextPath}/ComplejoServlet?action=listar" class="text-decoration-none">
                    <div class="quick-action-card blue">
                        <div class="card-body text-center p-3">
                            <div class="icon-container">
                                <i class="bi bi-calendar-check-fill fs-4"></i>
                            </div>
                            <div class="action-text">Reservar Cancha</div>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Acción 2: Buscar Jugadores -->
            <div class="col-6">
                <a href="#" class="text-decoration-none">
                    <div class="quick-action-card green">
                        <div class="card-body text-center p-3">
                            <div class="icon-container">
                                <i class="bi bi-people-fill fs-4"></i>
                            </div>
                            <div class="action-text">Buscar Jugadores</div>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Acción 3: Mis Torneos -->
            <div class="col-6">
                <a href="${pageContext.request.contextPath}/vistas/EnConstruccion.jsp" class="text-decoration-none">
                    <div class="quick-action-card orange">
                        <div class="card-body text-center p-3">
                            <div class="icon-container">
                                <i class="bi bi-trophy-fill fs-4"></i>
                            </div>
                            <div class="action-text">Mis Torneos</div>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Acción 4: Canchas Cercanas -->
            <div class="col-6">
                <a href="#" class="text-decoration-none">
                    <div class="quick-action-card purple">
                        <div class="card-body text-center p-3">
                            <div class="icon-container">
                                <i class="bi bi-geo-alt-fill fs-4"></i>
                            </div>
                            <div class="action-text">Canchas Cercanas</div>
                        </div>
                    </div>
                </a>
            </div>
        </div>

        <!-- ==== SECCIÓN: COMPLEJOS DESTACADOS ==== -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="section-title mb-0">Complejos Destacados</h2>
            <a href="${pageContext.request.contextPath}/ComplejoServlet?action=listar" class="text-link">
                Ver todos
            </a>
        </div>

        <c:forEach items="${complejosDestacados}" var="dto">
            <a href="${pageContext.request.contextPath}/CanchaServlet?action=listarPorComplejo&idComplejo=${dto.idComplejo}" class="text-decoration-none">
                <div class="field-card">
                    <!-- Header con gradiente -->
                    <div class="field-card-header">
                        <div class="d-flex align-items-center">
                            <div class="field-icon me-3">
                                <i class="bi bi-building"></i>
                            </div>
                            <div class="flex-grow-1">
                                <h5 class="mb-0 fw-bold">${dto.nombre}</h5>
                                <p class="mb-0 small opacity-90">${dto.direccion}</p>
                            </div>
                        </div>
                    </div>
                    <!-- Contenido -->
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <c:forEach items="${dto.deportes}" var="deporte" begin="0" end="0">
                                    <span class="sport-badge">${deporte}</span>
                                </c:forEach>
                            </div>
                            <i class="bi bi-chevron-right text-muted fs-4"></i>
                        </div>
                    </div>
                </div>
            </a>
        </c:forEach>

        <!-- ==== SECCIÓN: PRÓXIMOS PARTIDOS ==== -->
        <h2 class="section-title mt-4">Próximos Partidos</h2>
        
        <c:if test="${empty proximosPartidos}">
            <div class="card card-body text-center bg-light border">
                <p class="text-muted mb-1">No tienes próximos partidos.</p>
                <p class="mb-0"><a href="${pageContext.request.contextPath}/ComplejoServlet?action=listar" class="text-link fw-bold">¡Reserva uno ahora!</a></p>
            </div>
        </c:if>

        <c:forEach items="${proximosPartidos}" var="partidoDTO">
            <a href="${pageContext.request.contextPath}/EquipoServlet?action=verEquipo&idReserva=${partidoDTO.reserva.idReserva}" class="text-decoration-none">
                <div class="upcoming-match-card mb-2">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <h6 class="fw-bold mb-1">${partidoDTO.reserva.canchaidCancha.idComplejo.nombre}</h6>
                            <p class="text-muted small mb-1">
                                <fmt:formatDate value="${partidoDTO.reserva.fechaHoraInicio}" pattern="EEEE, d 'de' MMMM"/>
                            </p>
                            <p class="text-muted small mb-0">
                                <i class="bi bi-clock"></i> <fmt:formatDate value="${partidoDTO.reserva.fechaHoraInicio}" pattern="HH:mm"/> hs.
                            </p>
                        </div>
                        <div class="text-end">
                            <div class="match-status">
                                <i class="bi bi-people-fill"></i>
                                ${partidoDTO.jugadoresAceptados} / ${partidoDTO.reserva.canchaidCancha.capacidad * 2}
                            </div>
                        </div>
                    </div>
                </div>
            </a>
        </c:forEach>

    </main>

    <%-- Incluir la barra de navegación, indicando que 'home' es la página activa --%>
    <c:set var="activePage" value="home" scope="request"/>
    <jsp:include page="/vistas/navbar.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        var searchTimeout;
        var searchInput = document.getElementById('homeSearchInput');
        var searchResultsDiv = document.getElementById('searchResults');
        var contextPath = "${pageContext.request.contextPath}";

        searchInput.addEventListener('input', function() {
            clearTimeout(searchTimeout);
            var searchTerm = this.value;
            if (searchTerm.length > 2) { // Solo buscar si hay al menos 3 caracteres
                searchTimeout = setTimeout(function() {
                    fetchSearchResults(searchTerm);
                }, 300);
            } else {
                searchResultsDiv.style.display = 'none';
                searchResultsDiv.innerHTML = '';
            }
        });

        function fetchSearchResults(searchTerm) {
            fetch(contextPath + '/ManejadorServlet?action=searchComplejosAjax&searchTerm=' + encodeURIComponent(searchTerm))
                .then(function(response) {
                    return response.json();
                })
                .then(function(data) {
                    displaySearchResults(data);
                })
                .catch(function(error) {
                    console.error('Error fetching search results:', error);
                    searchResultsDiv.innerHTML = '<div class="list-group-item list-group-item-danger">Error al cargar resultados.</div>';
                    searchResultsDiv.style.display = 'block';
                });
        }

        function displaySearchResults(results) {
            searchResultsDiv.innerHTML = '';
            if (results.length > 0) {
                results.forEach(function(complejo) {
                    var resultItem = document.createElement('a');
                    resultItem.href = contextPath + '/CanchaServlet?action=listarPorComplejo&idComplejo=' + complejo.idComplejo;
                    resultItem.classList.add('list-group-item', 'list-group-item-action');
                    
                    var deportesHtml = '';
                    if (complejo.deportes && complejo.deportes.length > 0) {
                        deportesHtml = '<p class="mb-1 small">' + complejo.deportes.join(', ') + '</p>';
                    }

                    resultItem.innerHTML =
                        '<div class="d-flex w-100 justify-content-between">' +
                        '<h6 class="mb-1">' + complejo.nombre + '</h6>' +
                        '<small class="text-muted">' + complejo.localidad + ', ' + complejo.provincia + '</small>' +
                        '</div>' +
                        deportesHtml;
                    searchResultsDiv.appendChild(resultItem);
                });
                searchResultsDiv.style.display = 'block';
            } else {
                searchResultsDiv.innerHTML = '<div class="list-group-item">No se encontraron complejos.</div>';
                searchResultsDiv.style.display = 'block';
            }
        }

        // Ocultar resultados al hacer clic fuera
        document.addEventListener('click', function(event) {
            if (searchInput && !searchInput.contains(event.target) && !searchResultsDiv.contains(event.target)) {
                searchResultsDiv.style.display = 'none';
            }
        });
    </script>
</body>
</html>