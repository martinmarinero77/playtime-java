<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear Cuenta - PlayTime</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <style>
        :root {
            --primary-blue: #2563eb;
            --primary-blue-dark: #1e40af;
            --success-green: #10b981;
        }

        body {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--primary-blue-dark) 50%, #1e3a8a 100%);
            min-height: 100vh;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
        }

        /* ==== CONTENEDOR PRINCIPAL ==== */
        .register-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            padding: 2rem 0;
        }

        /* ==== CARD DE REGISTRO ==== */
        .register-card {
            background: white;
            border-radius: 24px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            overflow: hidden;
            animation: fadeInUp 0.6s ease-out;
            margin-bottom: 2rem;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* ==== HEADER CON GRADIENTE ==== */
        .register-header {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--primary-blue-dark) 100%);
            padding: 2rem 2rem;
            text-align: center;
            position: relative;
        }

        .logo-circle {
            width: 80px;
            height: 80px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .logo-circle .emoji {
            font-size: 2.5rem;
        }

        .brand-name {
            font-size: 1.75rem;
            font-weight: 800;
            color: white;
            margin-bottom: 0.25rem;
            letter-spacing: 1px;
        }

        .brand-tagline {
            color: rgba(255, 255, 255, 0.9);
            font-size: 0.9375rem;
            margin-bottom: 0;
        }

        /* ==== CUERPO DEL FORMULARIO ==== */
        .register-body {
            padding: 2rem 2rem;
        }

        .register-body::-webkit-scrollbar {
            width: 8px;
        }

        .register-body::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }

        .register-body::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 10px;
        }

        .register-body::-webkit-scrollbar-thumb:hover {
            background: #94a3b8;
        }

        /* ==== TÍTULOS DE SECCIÓN ==== */
        .section-title {
            font-size: 1.125rem;
            font-weight: bold;
            color: #1f2937;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #e5e7eb;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .section-title i {
            color: var(--primary-blue);
        }

        /* ==== CAMPOS DE FORMULARIO ==== */
        .form-label {
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.5rem;
            font-size: 0.875rem;
        }

        .input-group {
            margin-bottom: 1rem;
        }

        .input-group-text {
            background-color: white;
            border: 1px solid #d1d5db;
            border-right: none;
            color: var(--primary-blue);
        }

        .form-control {
            border: 1px solid #d1d5db;
            border-radius: 0 12px 12px 0;
            padding: 0.75rem 1rem;
            font-size: 0.9375rem;
            transition: all 0.2s;
        }

        .input-group .form-control {
            border-left: none;
        }

        .form-control:focus {
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .input-group:focus-within .input-group-text {
            border-color: var(--primary-blue);
        }

        .input-group-text {
            border-radius: 12px 0 0 12px;
        }

        /* Campos sin input-group */
        .form-control:not(.input-group .form-control) {
            border-radius: 12px;
        }

        /* ==== BOTÓN TOGGLE PASSWORD ==== */
        .btn-toggle-password {
            background: white;
            border: 1px solid #d1d5db;
            border-left: none;
            border-radius: 0 12px 12px 0;
            color: #6b7280;
            padding: 0 1rem;
            transition: all 0.2s;
        }

        .btn-toggle-password:hover {
            color: var(--primary-blue);
            background-color: #f9fafb;
        }

        /* ==== CHECKBOX ==== */
        .form-check-input:checked {
            background-color: var(--primary-blue);
            border-color: var(--primary-blue);
        }

        .form-check-label a {
            color: var(--primary-blue);
            font-weight: 600;
        }

        /* ==== INFO HELPER ==== */
        .info-badge {
            background-color: rgba(37, 99, 235, 0.05);
            border: 1px solid rgba(37, 99, 235, 0.2);
            border-radius: 8px;
            padding: 0.75rem;
            margin-bottom: 1.25rem;
            display: flex;
            align-items: start;
            gap: 0.5rem;
        }

        .info-badge i {
            color: var(--primary-blue);
            font-size: 1rem;
            margin-top: 2px;
        }

        .info-badge-text {
            font-size: 0.8125rem;
            color: #1e40af;
            margin: 0;
        }

        /* ==== BOTÓN DE REGISTRO ==== */
        .btn-register {
            background: linear-gradient(135deg, var(--success-green) 0%, #059669 100%);
            border: none;
            border-radius: 12px;
            padding: 0.875rem 2rem;
            font-size: 1rem;
            font-weight: 600;
            color: white;
            width: 100%;
            transition: all 0.3s;
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
        }

        .btn-register:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(16, 185, 129, 0.4);
        }

        .btn-register:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        /* ==== DIVIDER ==== */
        .divider {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 1.5rem 0;
        }

        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #e5e7eb;
        }

        .divider span {
            padding: 0 1rem;
            color: #6b7280;
            font-size: 0.875rem;
        }

        /* ==== BOTONES DE REDES SOCIALES ==== */
        .btn-social {
            border: 1.5px solid #e5e7eb;
            border-radius: 12px;
            padding: 0.75rem 1rem;
            background: white;
            color: #374151;
            font-weight: 500;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn-social:hover {
            border-color: var(--primary-blue);
            background-color: #f0f9ff;
            color: var(--primary-blue);
        }

        .btn-social .emoji {
            font-size: 1.5rem;
        }

        /* ==== LINK DE LOGIN ==== */
        .login-link {
            text-align: center;
            margin-top: 1.5rem;
            color: #6b7280;
        }

        .login-link a {
            color: var(--primary-blue);
            font-weight: 600;
            text-decoration: none;
            transition: color 0.2s;
        }

        .login-link a:hover {
            color: var(--primary-blue-dark);
            text-decoration: underline;
        }

        /* ==== ALERTAS ==== */
        .alert {
            border-radius: 12px;
            border: none;
            padding: 1rem 1.25rem;
            margin-bottom: 1.5rem;
        }

        .alert-danger {
            background-color: #fee2e2;
            color: #991b1b;
        }

        /* ==== VALIDACIÓN ==== */
        .is-invalid {
            border-color: #ef4444 !important;
        }

        .invalid-feedback {
            display: block;
            color: #dc2626;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }

        /* ==== RESPONSIVE ==== */
        @media (max-width: 576px) {
            .register-body {
                padding: 1.5rem 1.25rem;
                max-height: 65vh;
            }

            .register-header {
                padding: 1.5rem 1.25rem;
            }

            .brand-name {
                font-size: 1.5rem;
            }

            .logo-circle {
                width: 70px;
                height: 70px;
            }

            .logo-circle .emoji {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>

    <div class="register-container">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 col-sm-11 col-md-9 col-lg-7 col-xl-6">
                    
                    <!-- ==== CARD DE REGISTRO ==== -->
                    <div class="register-card">
                        
                        <!-- ==== HEADER CON GRADIENTE ==== -->
                        <div class="register-header">
                            <div class="logo-circle">
                                <span class="emoji">⚽</span>
                            </div>
                            <h1 class="brand-name">Crear Cuenta</h1>
                            <p class="brand-tagline">Completá tus datos para registrarte</p>
                        </div>
                        
                        <!-- ==== CUERPO DEL FORMULARIO ==== -->
                        <div class="register-body">
                            
                            <!-- ==== MENSAJES DE ERROR ==== -->
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger d-flex align-items-center" role="alert">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                    <div>${error}</div>
                                </div>
                            </c:if>

                            <!-- ==== FORMULARIO ==== -->
                            <form id="registroForm" action="UsuarioServlet" method="POST">
                                <input type="hidden" name="action" value="registrar">

                                <!-- ==== SECCIÓN: INFORMACIÓN PERSONAL ==== -->
                                <div class="section-title">
                                    <i class="bi bi-person-circle"></i>
                                    <span>Información Personal</span>
                                </div>

                                <!-- Nombre y Apellido -->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="nombre" class="form-label">Nombre</label>
                                            <div class="input-group">
                                                <span class="input-group-text">
                                                    <i class="bi bi-person"></i>
                                                </span>
                                                <input type="text" 
                                                       class="form-control" 
                                                       id="nombre" 
                                                       name="nombre" 
                                                       placeholder="Juan"
                                                       required
                                                       minlength="2">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="apellido" class="form-label">Apellido</label>
                                            <div class="input-group">
                                                <span class="input-group-text">
                                                    <i class="bi bi-person"></i>
                                                </span>
                                                <input type="text" 
                                                       class="form-control" 
                                                       id="apellido" 
                                                       name="apellido" 
                                                       placeholder="Pérez"
                                                       required
                                                       minlength="2">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Email -->
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-envelope"></i>
                                        </span>
                                        <input type="email" 
                                               class="form-control" 
                                               id="email" 
                                               name="email" 
                                               placeholder="tu@email.com"
                                               required>
                                    </div>
                                </div>

                                <!-- Teléfono -->
                                <div class="mb-3">
                                    <label for="telefono" class="form-label">Teléfono</label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-telephone"></i>
                                        </span>
                                        <input type="tel" 
                                               class="form-control" 
                                               id="telefono" 
                                               name="telefono" 
                                               placeholder="+54 264 123-4567"
                                               required
                                               minlength="8">
                                    </div>
                                </div>

                                <!-- Dirección (Opcional) -->
                                <div class="mb-3">
                                    <label for="direccion" class="form-label">Dirección <span class="text-muted small">(Opcional)</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-geo-alt"></i>
                                        </span>
                                        <input type="text" 
                                               class="form-control" 
                                               id="direccion" 
                                               name="direccion"
                                               placeholder="Av. Libertador 1234">
                                    </div>
                                </div>

                                <!-- Localidad y Provincia -->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="localidad" class="form-label">Localidad <span class="text-muted small">(Opcional)</span></label>
                                            <input type="text" 
                                                   class="form-control" 
                                                   id="localidad" 
                                                   name="localidad"
                                                   placeholder="San Juan">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="provincia" class="form-label">Provincia <span class="text-muted small">(Opcional)</span></label>
                                            <input type="text" 
                                                   class="form-control" 
                                                   id="provincia" 
                                                   name="provincia"
                                                   placeholder="San Juan">
                                        </div>
                                    </div>
                                </div>

                                <!-- ==== SECCIÓN: SEGURIDAD ==== -->
                                <div class="section-title mt-4">
                                    <i class="bi bi-shield-lock"></i>
                                    <span>Seguridad</span>
                                </div>

                                <!-- Contraseña -->
                                <div class="mb-3">
                                    <label for="password" class="form-label">Contraseña</label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-lock"></i>
                                        </span>
                                        <input type="password" 
                                               class="form-control" 
                                               id="password" 
                                               name="password" 
                                               placeholder="••••••••"
                                               required 
                                               minlength="6">
                                        <button class="btn btn-toggle-password" 
                                                type="button" 
                                                id="togglePassword">
                                            <i class="bi bi-eye-slash"></i>
                                        </button>
                                    </div>
                                </div>

                                <!-- Confirmar Contraseña -->
                                <div class="mb-3">
                                    <label for="confirmPassword" class="form-label">Confirmar Contraseña</label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-lock"></i>
                                        </span>
                                        <input type="password" 
                                               class="form-control" 
                                               id="confirmPassword" 
                                               name="confirmPassword" 
                                               placeholder="••••••••"
                                               required 
                                               minlength="6">
                                        <button class="btn btn-toggle-password" 
                                                type="button" 
                                                id="toggleConfirmPassword">
                                            <i class="bi bi-eye-slash"></i>
                                        </button>
                                    </div>
                                    <div id="passwordError" class="invalid-feedback" style="display: none;">
                                        Las contraseñas no coinciden
                                    </div>
                                </div>

                                <!-- Info Badge -->
                                <div class="info-badge">
                                    <i class="bi bi-info-circle-fill"></i>
                                    <p class="info-badge-text">
                                        La contraseña debe tener al menos 6 caracteres
                                    </p>
                                </div>

                                <!-- Términos y Condiciones -->
                                <div class="form-check mb-4">
                                    <input class="form-check-input" 
                                           type="checkbox" 
                                           id="acceptTerms" 
                                           required>
                                    <label class="form-check-label" for="acceptTerms">
                                        Acepto los 
                                        <a href="#" data-bs-toggle="modal" data-bs-target="#termsModal">
                                            términos y condiciones
                                        </a> 
                                        y la 
                                        <a href="#">política de privacidad</a>
                                    </label>
                                </div>

                                <!-- Botón Crear Cuenta -->
                                <button type="submit" 
                                        id="submitButton" 
                                        class="btn btn-register" 
                                        disabled>
                                    <i class="bi bi-person-plus me-2"></i>
                                    Crear Cuenta
                                </button>
                            </form>
                            
                            <!-- Divider -->
                            <div class="divider">
                                <span>O registrarse con</span>
                            </div>

                            <!-- Link a Login -->
                            <div class="login-link">
                                ¿Ya tenés cuenta? 
                                <a href="${pageContext.request.contextPath}/UsuarioServlet?action=mostrar_login">
                                    Iniciar Sesión
                                </a>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Modal Términos y Condiciones -->
    <div class="modal fade" id="termsModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-scrollable modal-lg">
            <div class="modal-content" style="border-radius: 16px;">
                <div class="modal-header border-0">
                    <h5 class="modal-title fw-bold">
                        <i class="bi bi-file-text text-primary me-2"></i>
                        Términos y Condiciones
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <h6 class="fw-bold">1. Aceptación de términos</h6>
                    <p class="text-muted">Al usar PlayTime, aceptas estos términos...</p>
                    
                    <h6 class="fw-bold">2. Uso del servicio</h6>
                    <p class="text-muted">PlayTime proporciona una plataforma para reservar canchas deportivas...</p>
                    
                    <h6 class="fw-bold">3. Privacidad</h6>
                    <p class="text-muted">Tus datos personales serán protegidos según nuestra política de privacidad...</p>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">
                        He leído y acepto
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Toggle mostrar/ocultar contraseña
        document.getElementById('togglePassword').addEventListener('click', function () {
            const passwordInput = document.getElementById('password');
            const icon = this.querySelector('i');
            
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            
            if (type === 'password') {
                icon.classList.remove('bi-eye');
                icon.classList.add('bi-eye-slash');
            } else {
                icon.classList.remove('bi-eye-slash');
                icon.classList.add('bi-eye');
            }
        });

        // Toggle confirmar contraseña
        document.getElementById('toggleConfirmPassword').addEventListener('click', function () {
            const passwordInput = document.getElementById('confirmPassword');
            const icon = this.querySelector('i');
            
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            
            if (type === 'password') {
                icon.classList.remove('bi-eye');
                icon.classList.add('bi-eye-slash');
            } else {
                icon.classList.remove('bi-eye-slash');
                icon.classList.add('bi-eye');
            }
        });

        // Validación en tiempo real
        const pass1 = document.getElementById('password');
        const pass2 = document.getElementById('confirmPassword');
        const terms = document.getElementById('acceptTerms');
        const submitBtn = document.getElementById('submitButton');
        const passError = document.getElementById('passwordError');

        function validateForm() {
            let passwordsMatch = false;
            
            // Validar coincidencia de contraseñas
            if (pass1.value.length > 0 && pass1.value === pass2.value) {
                pass2.classList.remove('is-invalid');
                passError.style.display = 'none';
                passwordsMatch = true;
            } else if (pass2.value.length > 0) {
                pass2.classList.add('is-invalid');
                passError.style.display = 'block';
                passwordsMatch = false;
            } else {
                pass2.classList.remove('is-invalid');
                passError.style.display = 'none';
                passwordsMatch = false;
            }

            // Validar términos y habilitar botón
            if (passwordsMatch && terms.checked && pass1.value.length >= 6) {
                submitBtn.disabled = false;
            } else {
                submitBtn.disabled = true;
            }
        }
        
        // Escuchar eventos
        pass1.addEventListener('input', validateForm);
        pass2.addEventListener('input', validateForm);
        terms.addEventListener('change', validateForm);

    </script>
</body>
</html>