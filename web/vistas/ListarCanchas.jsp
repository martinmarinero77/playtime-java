<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${complejo.nombre}"/> - SportReserva</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        :root { --primary-blue: #2563eb; --primary-blue-dark: #1e40af; }
        body { background-color: #f8f9fa; }
        .main-header { background: linear-gradient(90deg, var(--primary-blue) 0%, var(--primary-blue-dark) 100%); color: white; }
        .btn-back { width: 40px; height: 40px; background-color: rgba(255, 255, 255, 0.2); border: none; border-radius: 50%; color: white; display: flex; align-items: center; justify-content: center; text-decoration: none; transition: background-color 0.2s; }
        .btn-back:hover { background-color: rgba(255, 255, 255, 0.3); }
        .date-section, .filter-section { background-color: white; padding: 1rem; border-bottom: 1px solid #e5e7eb; }
        .filter-chip { display: inline-block; padding: 6px 16px; border-radius: 16px; background-color: #f3f4f6; color: #374151; font-size: 0.875rem; font-weight: 500; border: none; cursor: pointer; transition: all 0.2s; }
        .filter-chip:hover { background-color: #e5e7eb; }
        .filter-chip.active { background-color: var(--primary-blue); color: white; }
        .cancha-card { border-radius: 16px; border: 1px solid #e5e7eb; background-color: white; overflow: hidden; transition: transform 0.2s, box-shadow 0.2s; margin-bottom: 1rem; cursor: pointer; }
        .cancha-card:hover { transform: translateY(-3px); box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .cancha-number { width: 60px; height: 60px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.75rem; font-weight: bold; color: white; background: var(--primary-blue); }
        .price-badge { background-color: rgba(16, 185, 129, 0.1); color: #065f46; padding: 0.5rem 0.75rem; border-radius: 8px; }
        .empty-state { text-align: center; padding: 3rem 1rem; }
        .empty-state-icon { font-size: 4rem; color: #d1d5db; margin-bottom: 1rem; }
        .time-slot { border: 1px solid #e5e7eb; border-radius: 8px; padding: 10px; text-align: center; cursor: pointer; transition: all 0.2s; }
        .time-slot:hover:not(.disabled) { background-color: #e9ecef; }
        .time-slot.selected { background-color: var(--primary-blue); color: white; border-color: var(--primary-blue); }
        .time-slot.disabled { background-color: #f8f9fa; color: #adb5bd; cursor: not-allowed; }
        .summary-box { border: 1px solid #e5e7eb; }
        .summary-box .cancha-icon { width: 48px; height: 48px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; }
    </style>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var contextPath = '${pageContext.request.contextPath}';
            var datePicker = document.getElementById('datePicker');
            var horariosModal = new bootstrap.Modal(document.getElementById('horariosModal'));
            var confirmarReservaModal = new bootstrap.Modal(document.getElementById('confirmarReservaModal'));
            var statusModalEl = document.getElementById('statusModal');
            var statusModal = new bootstrap.Modal(statusModalEl);
            
            var selectedCancha = {};
            var selectedHorario = null;

            // --- INICIALIZACIÓN ---
            if(datePicker) {
                var today = new Date();
                var yyyy = today.getFullYear();
                var mm = today.getMonth() + 1;
                if (mm < 10) mm = '0' + mm;
                var dd = today.getDate();
                if (dd < 10) dd = '0' + dd;
                var todayStr = yyyy + '-' + mm + '-' + dd;
                datePicker.value = todayStr;
                datePicker.min = todayStr;
            }
            
            // --- FUNCIÓN PARA MODAL DE ESTADO ---
            function showStatusModal(title, message, type) {
                var icon = document.getElementById('statusModalIcon');
                var titleEl = document.getElementById('statusModalTitle');
                var messageEl = document.getElementById('statusModalMessage');
                var button = document.getElementById('statusModalButton');

                titleEl.textContent = title;
                messageEl.textContent = message;

                icon.className = 'fs-1 mb-3'; 
                button.className = 'btn w-100';

                if (type === 'success') {
                    icon.classList.add('bi-check-circle-fill', 'text-success');
                    button.classList.add('btn-success');
                } else { // 'error'
                    icon.classList.add('bi-x-circle-fill', 'text-danger');
                    button.classList.add('btn-danger');
                }
                
                statusModal.show();
            }

            // --- FILTRO ---
            window.filterBySport = function(sport, element) {
                document.querySelectorAll('.filter-chip').forEach(function(chip) {
                    chip.classList.remove('active');
                });
                element.classList.add('active');
                var cards = document.querySelectorAll('.cancha-card');
                var visibleCount = 0;
                cards.forEach(function(card) {
                    var cardSport = card.dataset.sport || '';
                    if (sport === 'all' || cardSport.toLowerCase() === sport.toLowerCase()) {
                        card.style.display = '';
                        visibleCount++;
                    } else {
                        card.style.display = 'none';
                    }
                });
                document.getElementById('noResultsFiltered').style.display = visibleCount === 0 ? 'block' : 'none';
            };

            // --- LÓGICA DE RESERVA ---

            // 1. Abrir modal de horarios
            window.showHorariosModal = function(canchaId, canchaNumero, canchaDeporte, canchaPrecio) {
                selectedCancha = { id: canchaId, numero: canchaNumero, deporte: canchaDeporte, precio: canchaPrecio };
                actualizarHorariosDisponibles();
                horariosModal.show();
            };

            function actualizarHorariosDisponibles() {
                if (!selectedCancha.id) return;

                var selectedDate = datePicker.value;
                var displayDate = new Date(selectedDate + 'T00:00:00').toLocaleDateString('es-ES', { weekday: 'long', day: 'numeric', month: 'long' });

                document.getElementById('modalCanchaTitle').textContent = 'Cancha N° ' + selectedCancha.numero + ' (' + selectedCancha.deporte + ')';
                document.getElementById('modalDateSubtitle').textContent = displayDate;
                
                var grid = document.getElementById('horariosGrid');
                grid.innerHTML = '<div class="col-12 text-center py-5"><div class="spinner-border text-primary"></div><p class="text-muted mt-2">Cargando disponibilidad...</p></div>';

                fetch(contextPath + '/ReservaServlet?action=getHorarios&idCancha=' + selectedCancha.id + '&fecha=' + selectedDate)
                    .then(function(response) {
                        if (!response.ok) { throw new Error('Error al cargar horarios: ' + response.statusText); }
                        return response.json();
                    })
                    .then(function(horasOcupadas) { renderizarHorarios(horasOcupadas); })
                    .catch(function(error) {
                        console.error('Error en fetch:', error);
                        grid.innerHTML = '<div class="col-12 text-center py-5"><p class="text-danger">No se pudo cargar la disponibilidad. Intente más tarde.</p></div>';
                    });
            }
            
            if(datePicker) {
                datePicker.addEventListener('change', function() {
                    if (document.getElementById('horariosModal').classList.contains('show')) {
                        actualizarHorariosDisponibles();
                    }
                });
            }

            function renderizarHorarios(horasOcupadas) {
                var grid = document.getElementById('horariosGrid');
                var horarios = [15, 16, 17, 18, 19, 20, 21, 22, 23];
                var now = new Date();
                var selectedDate = datePicker.value;
                var isToday = (new Date(selectedDate + 'T00:00:00').toDateString() === now.toDateString());
                var currentHour = now.getHours();
                
                grid.innerHTML = '';
                if (horarios.length === 0) {
                    grid.innerHTML = '<div class="col-12 text-center"><p>No hay horarios definidos.</p></div>';
                    return;
                }

                for (var i = 0; i < horarios.length; i++) {
                    var hour = horarios[i];
                    var isPast = isToday && hour <= currentHour;
                    var isOccupied = horasOcupadas.indexOf(hour) !== -1;
                    
                    var col = document.createElement('div');
                    col.className = 'col-4';
                    var btn = document.createElement('button');
                    btn.textContent = hour + ':00';
                    btn.disabled = isPast || isOccupied;

                    var btnClass = 'btn w-100 ' + (isPast || isOccupied ? 'btn-secondary disabled' : 'btn-outline-primary');
                    btn.className = btnClass;

                    if (!isPast && !isOccupied) {
                        (function(h) { btn.onclick = function() { selectHorario(h); }; })(hour);
                    }
                    
                    col.appendChild(btn);
                    grid.appendChild(col);
                }
            }

            function selectHorario(hour) {
                selectedHorario = hour;
                horariosModal.hide();

                var displayDate = new Date(datePicker.value + 'T00:00:00').toLocaleDateString('es-ES', { day: 'numeric', month: 'long', year: 'numeric' });

                document.getElementById('confirmCancha').textContent = 'Cancha N° ' + selectedCancha.numero + ' (' + selectedCancha.deporte + ')';
                document.getElementById('confirmComplejo').textContent = '<c:out value="${complejo.nombre}"/>';
                document.getElementById('confirmHorario').textContent = displayDate + ' a las ' + selectedHorario + ':00 hs';
                document.getElementById('confirmPrecio').textContent = '$' + selectedCancha.precio;
                
                confirmarReservaModal.show();
            }

            window.confirmarReserva = function() {
                var confirmBtn = document.getElementById('btnConfirmarReserva');
                var btnText = confirmBtn.querySelector('.btn-text');
                var btnSpinner = confirmBtn.querySelector('.spinner-border');

                confirmBtn.disabled = true;
                btnText.textContent = 'Procesando...';
                btnSpinner.classList.remove('d-none');

                var horaStr = String(selectedHorario);
                if (horaStr.length < 2) horaStr = '0' + horaStr;
                var dateTimeStr = datePicker.value + 'T' + horaStr + ':00';

                fetch(contextPath + '/ReservaServlet?action=crearReserva', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ idCancha: selectedCancha.id, horaInicio: dateTimeStr })
                })
                .then(function(response) {
                    confirmarReservaModal.hide();
                    if (response.status === 201) {
                        showStatusModal('¡Éxito!', 'Tu reserva ha sido creada correctamente.', 'success');
                        statusModalEl.addEventListener('hidden.bs.modal', function () {
                            actualizarHorariosDisponibles();
                        }, { once: true });
                    } else {
                        response.json().then(function(errorData) {
                            showStatusModal('Error al Reservar', errorData.message || 'Ocurrió un error.', 'error');
                        });
                    }
                })
                .catch(function(error) {
                    console.error('Error en fetch al crear reserva:', error);
                    confirmarReservaModal.hide();
                    showStatusModal('Error de Conexión', 'No se pudo comunicar con el servidor.', 'error');
                })
                .finally(function() {
                    confirmBtn.disabled = false;
                    btnText.textContent = 'Confirmar Reserva';
                    btnSpinner.classList.add('d-none');
                });
            };
        });
    </script>
</head>
<body>

    <header class="main-header">
        <div class="container py-3">
            <div class="d-flex align-items-center mb-3">
                <a href="ComplejoServlet?action=listar" class="btn-back me-3">
                    <i class="bi bi-arrow-left fs-5"></i>
                </a>
                <div class="flex-grow-1">
                    <h1 class="h4 mb-0 fw-bold"><c:out value="${complejo.nombre}"/></h1>
                    <p class="mb-0 small opacity-75">Seleccioná tu cancha</p>
                </div>
            </div>
        </div>
    </header>

    <div class="date-section">
        <div class="container">
            <label for="datePicker" class="fw-bold form-label">Seleccionar Fecha</label>
            <input type="date" id="datePicker" class="form-control" value="${todayDate}" min="${todayDate}">
        </div>
    </div>

    <c:if test="${not empty deportesDisponibles && deportesDisponibles.size() > 1}">
        <div class="filter-section">
            <div class="container">
                <div class="d-flex align-items-center mb-2">
                    <i class="bi bi-filter-circle text-primary me-2"></i>
                    <span class="fw-bold small">Filtrar por deporte</span>
                </div>
                <div class="d-flex overflow-auto pb-2" style="gap: 0.5rem;">
                    <button class="filter-chip active" data-sport="all" onclick="filterBySport('all', this)">Todos</button>
                    <c:forEach items="${deportesDisponibles}" var="deporte">
                        <button class="filter-chip" data-sport="${deporte.nombre}" onclick="filterBySport('${deporte.nombre != null ? deporte.nombre : ''}', this)">
                            <c:out value="${deporte.nombre}"/>
                        </button>
                    </c:forEach>
                </div>
            </div>
        </div>
    </c:if>

    <main class="container py-3">
        <c:if test="${empty canchas}">
            <div class="empty-state">
                <i class="bi bi-clipboard-x empty-state-icon"></i>
                <h5 class="fw-bold text-dark">No hay canchas disponibles</h5>
                <p class="text-muted">Este complejo no tiene canchas registradas</p>
            </div>
        </c:if>

        <div id="canchasList">
            <c:forEach items="${canchas}" var="cancha">
                <div class="cancha-card" 
                     data-cancha-id="${cancha.idCancha}"
                     data-cancha-numero="${cancha.numero}"
                     data-cancha-deporte="${cancha.idDeporte.nombre}"
                     data-cancha-tipo="${cancha.tipo}"
                     data-cancha-precio="${cancha.precio}"
                     data-sport="${cancha.idDeporte.nombre}"
                     onclick="showHorariosModal(
                         '${cancha.idCancha}', 
                         '${cancha.numero != null ? cancha.numero : 'N/A'}', 
                         '${cancha.idDeporte.nombre != null ? cancha.idDeporte.nombre : ''}',
                         '${cancha.precio != null ? cancha.precio : '0'}'
                     )">
                    <div class="card-body p-3">
                        <div class="row align-items-center">
                            <div class="col-auto"><div class="cancha-number"><c:out value="${cancha.numero}"/></div></div>
                            <div class="col">
                                <h5 class="fw-bold mb-1"><c:out value="${cancha.idDeporte.nombre}"/></h5>
                                <p class="text-muted small mb-2"><c:out value="${cancha.tipo}"/></p>
                                <div class="d-flex align-items-center text-muted small"><i class="bi bi-people me-1"></i><span><c:out value="${cancha.capacidad}"/> jugadores</span></div>
                            </div>
                            <div class="col-auto text-end">
                                <div class="price-badge mb-2"><div class="fw-bold fs-5" style="color: #065f46;">$<c:out value="${cancha.precio}"/></div></div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div id="noResultsFiltered" class="empty-state" style="display: none;">
            <i class="bi bi-filter-circle-fill empty-state-icon"></i>
            <h5 class="fw-bold text-dark">No hay canchas de este deporte</h5>
            <p class="text-muted">Probá con otro filtro</p>
        </div>
    </main>

    <!-- MODAL: STATUS (Success/Error) -->
    <div class="modal fade" id="statusModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="border-radius: 1rem;">
                <div class="modal-body text-center p-4">
                    <i id="statusModalIcon" class="fs-1 mb-3"></i>
                    <h5 class="modal-title fw-bold mb-2" id="statusModalTitle"></h5>
                    <p id="statusModalMessage"></p>
                    <button type="button" class="btn btn-primary w-100" id="statusModalButton" data-bs-dismiss="modal">Aceptar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- MODAL: HORARIOS -->
    <div class="modal fade" id="horariosModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <div>
                        <h5 class="modal-title fw-bold" id="modalCanchaTitle"></h5>
                        <p class="text-muted small mb-0" id="modalDateSubtitle"></p>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body"><div class="row g-2" id="horariosGrid"></div></div>
            </div>
        </div>
    </div>

    <!-- MODAL: CONFIRMAR RESERVA (REDESIGN) -->
    <div class="modal fade" id="confirmarReservaModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="border-radius: 1rem;">
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title fw-bold ps-2">Resumen de tu Reserva</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="summary-box bg-light p-3 rounded-3 mb-4">
                        <div class="d-flex align-items-center mb-3">
                            <div class="cancha-icon bg-primary text-white me-3">
                                <i class="bi bi-dribbble"></i>
                            </div>
                            <div>
                                <h6 class="fw-bold mb-0" id="confirmCancha"></h6>
                                <small class="text-muted" id="confirmComplejo"></small>
                            </div>
                        </div>
                        <hr class="my-2">
                        <ul class="list-unstyled mb-0">
                            <li class="d-flex align-items-center py-2">
                                <i class="bi bi-calendar-event text-primary me-3 fs-5"></i>
                                <span id="confirmHorario"></span>
                            </li>
                            <li class="d-flex align-items-center py-2 border-top">
                                <i class="bi bi-cash-coin text-primary me-3 fs-5"></i>
                                <span>Precio Final:</span>
                                <span class="fw-bold fs-5 ms-auto" id="confirmPrecio"></span>
                            </li>
                        </ul>
                    </div>
                    <div class="d-grid">
                        <button type="button" class="btn btn-primary btn-lg" id="btnConfirmarReserva" onclick="confirmarReserva()">
                            <span class="spinner-border spinner-border-sm d-none me-2" role="status" aria-hidden="true"></span>
                            <span class="btn-text">Confirmar Reserva</span>
                        </button>
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0 justify-content-center">
                    <button type="button" class="btn btn-link text-secondary" data-bs-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
