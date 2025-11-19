<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complejos Deportivos - PlayTime</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        :root { --primary-blue: #2563eb; --primary-blue-dark: #1e40af; }
        body { background-color: #f9fafb; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; }
        .main-header { background: linear-gradient(90deg, var(--primary-blue) 0%, var(--primary-blue-dark) 100%); color: white; padding: 1rem 0; }
        .btn-back { width: 40px; height: 40px; background-color: rgba(255, 255, 255, 0.2); border: none; border-radius: 50%; color: white; display: flex; align-items: center; justify-content: center; text-decoration: none; transition: background-color 0.2s; }
        .btn-back:hover { background-color: rgba(255, 255, 255, 0.3); color: white; }
        .header-icon { width: 48px; height: 48px; background-color: rgba(255, 255, 255, 0.2); border-radius: 12px; display: flex; align-items: center; justify-content: center; }
        .search-bar { background-color: white; border-radius: 12px; border: none; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1); }
        .search-bar .form-control, .search-bar .input-group-text { background-color: white; border: none; box-shadow: none !important; }
        .filter-section { background-color: white; padding: 1rem; }
        .filter-chip { display: inline-block; padding: 6px 16px; border-radius: 16px; background-color: #f3f4f6; color: #374151; font-size: 0.875rem; font-weight: 500; border: none; cursor: pointer; transition: all 0.2s; white-space: nowrap; }
        .filter-chip:hover { background-color: #e5e7eb; }
        .filter-chip.active { background-color: var(--primary-blue); color: white; }
        .results-counter { background-color: white; padding: 0.75rem 1rem; border-bottom: 1px solid #e5e7eb; }
        .complex-card { border-radius: 16px; border: 1px solid #e5e7eb; background-color: white; overflow: hidden; transition: transform 0.2s, box-shadow 0.2s; margin-bottom: 1rem; text-decoration: none; color: inherit; display: block; }
        .complex-card:hover { transform: translateY(-2px); box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1); }
        .complex-icon { width: 56px; height: 56px; background: linear-gradient(135deg, #60a5fa 0%, #3b82f6 100%); border-radius: 12px; display: flex; align-items: center; justify-content: center; color: white; font-size: 1.75rem; }
        .complex-name { font-size: 1.125rem; font-weight: bold; color: #1f2937; }
        .info-row { display: flex; align-items: center; font-size: 0.875rem; color: #6b7280; margin-bottom: 0.5rem; }
        .info-row i { font-size: 1rem; margin-right: 0.5rem; }
        .sport-tag { display: inline-block; padding: 4px 12px; background-color: rgba(59, 130, 246, 0.1); color: #1e40af; font-size: 0.75rem; font-weight: 500; border-radius: 16px; border: 1px solid rgba(59, 130, 246, 0.2); margin-right: 0.5rem; margin-bottom: 0.5rem; }
        .no-results { text-align: center; padding: 3rem 1rem; }
        .no-results-icon { font-size: 5rem; color: #d1d5db; margin-bottom: 1rem; }
    </style>
</head>
<body>

    <header class="main-header">
        <div class="container">
            <div class="d-flex align-items-center mb-3">
                <a href="${pageContext.request.contextPath}/ManejadorServlet?action=home" class="btn-back me-3">
                    <i class="bi bi-arrow-left fs-5"></i>
                </a>
                <div class="flex-grow-1">
                    <h1 class="h4 mb-0 fw-bold">Complejos Deportivos</h1>
                    <p class="mb-0 small opacity-75">Encontrá el lugar perfecto</p>
                </div>
                <div class="header-icon"><i class="bi bi-buildings fs-4"></i></div>
            </div>
        </div>
    </header>

    <div class="filter-section">
        <div class="container">
            <div class="d-flex align-items-center mb-2"><i class="bi bi-filter-circle text-primary me-2"></i><span class="fw-bold small">Filtrar por deporte</span></div>
            <div class="d-flex overflow-auto pb-2" style="gap: 0.5rem;">
                <button class="filter-chip active" data-sport="all" onclick="filterBySport('all', this)">Todos</button>
                <c:forEach items="${deportesDisponibles}" var="deporte">
                    <button class="filter-chip" data-sport="${deporte.nombre.toLowerCase()}" onclick="filterBySport('${deporte.nombre.toLowerCase()}', this)">
                        <c:out value="${deporte.nombre}"/>
                    </button>
                </c:forEach>
            </div>
        </div>
    </div>

    <div class="results-counter">
        <div class="container">
            <div class="d-flex align-items-center"><i class="bi bi-info-circle text-muted me-2"></i>
                <span class="small text-muted" id="resultsCount"></span>
            </div>
        </div>
    </div>

    <main class="container py-3">
        <c:choose>
            <c:when test="${not empty listaComplejosDTO}">
                <div id="complexList">
                    <c:forEach items="${listaComplejosDTO}" var="dto">
                    <a href="${pageContext.request.contextPath}/CanchaServlet?action=listarPorComplejo&idComplejo=${dto.idComplejo}" 
                       class="complex-card" 
                       data-name="<c:out value='${dto.nombre.toLowerCase()}'/>" 
                       data-location="<c:out value='${dto.localidad.toLowerCase()}'/>"
                       data-sports="${dto.getDeportesAsString()}">
                        <div class="card-body p-3">
                            <div class="d-flex align-items-start mb-3">
                                <div class="complex-icon me-3"><i class="bi bi-building"></i></div>
                                <div class="flex-grow-1">
                                    <h3 class="complex-name mb-0"><c:out value="${dto.nombre}"/></h3>
                                </div>
                                <i class="bi bi-chevron-right text-muted"></i>
                            </div>
                            <div class="info-row"><i class="bi bi-geo-alt-fill text-danger"></i><span><c:out value="${dto.direccion}"/>, <c:out value="${dto.localidad}"/></span></div>
                            <div class="info-row mb-3"><i class="bi bi-telephone-fill text-success"></i><span><c:out value="${dto.telefono}"/></span></div>
                            <c:if test="${not empty dto.deportes}">
                                <div class="mb-3">
                                    <div>
                                        <c:forEach items="${dto.deportes}" var="deporte">
                                            <span class="sport-tag"><c:out value="${deporte}"/></span>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </a>
                </c:forEach>
                </div>
                <div id="noResultsFiltered" class="no-results" style="display: none;">
                    <i class="bi bi-search no-results-icon"></i>
                    <h5 class="fw-bold text-dark mb-2">No se encontraron resultados</h5>
                    <p class="text-muted">Intentá con otra búsqueda o filtro.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-results">
                    <i class="bi bi-building-x no-results-icon"></i>
                    <h5 class="fw-bold text-dark mb-2">No hay complejos disponibles</h5>
                    <p class="text-muted">Actualmente no hay complejos registrados en la base de datos.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </main>

    <script>
        let currentSportFilter = 'all';
        
        function applyFilters() {
            const cards = document.querySelectorAll('.complex-card');
            let visibleCount = 0;

            cards.forEach(card => {
                const sports = card.getAttribute('data-sports');
                const matchesSport = currentSportFilter === 'all' || sports.includes(currentSportFilter);

                if (matchesSport) {
                    card.style.display = 'block';
                    visibleCount++;
                } else {
                    card.style.display = 'none';
                }
            });

            document.getElementById('resultsCount').textContent = visibleCount + (visibleCount === 1 ? ' complejo encontrado' : ' complejos encontrados');
            document.getElementById('noResultsFiltered').style.display = visibleCount === 0 ? 'block' : 'none';
            document.getElementById('complexList').style.display = visibleCount > 0 ? 'block' : 'none';
        }

        function filterBySport(sport, element) {
            document.querySelectorAll('.filter-chip').forEach(chip => chip.classList.remove('active'));
            element.classList.add('active');
            currentSportFilter = sport;
            applyFilters();
        }

        // Llamada inicial para establecer el contador de resultados
        document.addEventListener('DOMContentLoaded', function() {
            applyFilters();
        });
    </script>
</body>
</html>
