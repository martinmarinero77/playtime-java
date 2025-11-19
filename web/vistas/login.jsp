<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión - PlayTime</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <style>
        :root {
            --primary-blue: #2563eb;
            --primary-blue-dark: #1e40af;
            --primary-blue-light: #3b82f6;
        }

        body {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--primary-blue-dark) 50%, #1e3a8a 100%);
            min-height: 100vh;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
        }

        /* ==== CONTENEDOR PRINCIPAL ==== */
        .login-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            padding: 2rem 0;
        }

        /* ==== CARD DE LOGIN ==== */
        .login-card {
            background: white;
            border-radius: 24px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            overflow: hidden;
            animation: fadeInUp 0.6s ease-out;
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
        .login-header {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--primary-blue-dark) 100%);
            padding: 3rem 2rem;
            text-align: center;
            position: relative;
        }

        .logo-circle {
            width: 100px;
            height: 100px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
        }

        .logo-circle .emoji {
            font-size: 3.5rem;
        }

        .brand-name {
            font-size: 2rem;
            font-weight: 800;
            color: white;
            margin-bottom: 0.5rem;
            letter-spacing: 1px;
        }

        .brand-tagline {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1rem;
            margin-bottom: 0;
        }

        /* ==== CUERPO DEL FORMULARIO ==== */
        .login-body {
            padding: 2.5rem 2rem;
        }

        .welcome-text {
            font-size: 1.75rem;
            font-weight: bold;
            color: #1f2937;
            margin-bottom: 0.5rem;
        }

        .welcome-subtitle {
            color: #6b7280;
            margin-bottom: 2rem;
        }

        /* ==== CAMPOS DE FORMULARIO ==== */
        .form-label {
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.5rem;
            font-size: 0.875rem;
        }

        .input-group {
            margin-bottom: 1.25rem;
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

        /* ==== CHECKBOX Y LINKS ==== */
        .form-check-input:checked {
            background-color: var(--primary-blue);
            border-color: var(--primary-blue);
        }

        .forgot-password {
            color: var(--primary-blue);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.875rem;
            transition: color 0.2s;
        }

        .forgot-password:hover {
            color: var(--primary-blue-dark);
            text-decoration: underline;
        }

        /* ==== BOTÓN DE LOGIN ==== */
        .btn-login {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--primary-blue-dark) 100%);
            border: none;
            border-radius: 12px;
            padding: 0.875rem 2rem;
            font-size: 1rem;
            font-weight: 600;
            color: white;
            width: 100%;
            transition: all 0.3s;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(37, 99, 235, 0.4);
        }

        .btn-login:active {
            transform: translateY(0);
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

        /* ==== LINK DE REGISTRO ==== */
        .register-link {
            text-align: center;
            margin-top: 1.5rem;
            color: #6b7280;
        }

        .register-link a {
            color: var(--primary-blue);
            font-weight: 600;
            text-decoration: none;
            transition: color 0.2s;
        }

        .register-link a:hover {
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

        .alert-success {
            background-color: #d1fae5;
            color: #065f46;
        }

        /* ==== RESPONSIVE ==== */
        @media (max-width: 576px) {
            .login-body {
                padding: 1.5rem 1.25rem;
            }

            .login-header {
                padding: 2rem 1.25rem;
            }

            .brand-name {
                font-size: 1.75rem;
            }

            .logo-circle {
                width: 80px;
                height: 80px;
            }

            .logo-circle .emoji {
                font-size: 2.5rem;
            }
        }
    </style>
</head>
<body>

    <div class="login-container">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 col-sm-10 col-md-8 col-lg-6 col-xl-5">
                    
                    <!-- ==== CARD DE LOGIN ==== -->
                    <div class="login-card">
                        
                        <!-- ==== HEADER CON GRADIENTE ==== -->
                        <div class="login-header">
                            <div class="logo-circle">
                                <span class="emoji">⚽</span>
                            </div>
                            <h1 class="brand-name">PlayTime</h1>
                            <p class="brand-tagline">Reservá tu cancha en segundos</p>
                        </div>
                        
                        <!-- ==== CUERPO DEL FORMULARIO ==== -->
                        <div class="login-body">
                            <h2 class="welcome-text">¡Bienvenido!</h2>
                            <p class="welcome-subtitle">Iniciá sesión para continuar</p>
                            
                            <!-- ==== MENSAJES DE ERROR/ÉXITO ==== -->
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger d-flex align-items-center" role="alert">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                    <div>${error}</div>
                                </div>
                            </c:if>
                            
                            <c:if test="${not empty mensaje}">
                                <div class="alert alert-success d-flex align-items-center" role="alert">
                                    <i class="bi bi-check-circle-fill me-2"></i>
                                    <div>${mensaje}</div>
                                </div>
                            </c:if>

                            <!-- ==== FORMULARIO ==== -->
                            <form id="loginForm" action="UsuarioServlet" method="POST">
                                <input type="hidden" name="action" value="loguear">

                                <!-- Campo Email -->
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
                                               required
                                               autocomplete="email">
                                    </div>
                                </div>

                                <!-- Campo Contraseña -->
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
                                               minlength="6"
                                               autocomplete="current-password">
                                        <button class="btn btn-toggle-password" 
                                                type="button" 
                                                id="togglePassword"
                                                aria-label="Mostrar contraseña">
                                            <i class="bi bi-eye-slash"></i>
                                        </button>
                                    </div>
                                </div>

                                <!-- Recordarme / Olvidé contraseña -->
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <div class="form-check">
                                        <input class="form-check-input" 
                                               type="checkbox" 
                                               name="remember" 
                                               id="rememberMe">
                                        <label class="form-check-label" for="rememberMe">
                                            Recordarme
                                        </label>
                                    </div>
                                    <a href="#" class="forgot-password">
                                        ¿Olvidaste tu contraseña?
                                    </a>
                                </div>

                                <!-- Botón Iniciar Sesión -->
                                <button type="submit" class="btn btn-login">
                                    <i class="bi bi-box-arrow-in-right me-2"></i>
                                    Iniciar Sesión
                                </button>
                            </form>
                            
                            <!-- Divider -->
                            <div class="divider">
                                <span>O continuar con</span>
                            </div>

                            <!-- Link a Registro -->
                            <div class="register-link">
                                ¿No tenés cuenta? 
                                <a href="${pageContext.request.contextPath}/UsuarioServlet?action=mostrar_registro">
                                    Crear Cuenta
                                </a>
                            </div>
                        </div>
                    </div>

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
            
            // Cambiar tipo de input
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            
            // Cambiar ícono
            if (type === 'password') {
                icon.classList.remove('bi-eye');
                icon.classList.add('bi-eye-slash');
            } else {
                icon.classList.remove('bi-eye-slash');
                icon.classList.add('bi-eye');
            }
        });


        // Animación suave al cargar
        window.addEventListener('load', function() {
            document.querySelector('.login-card').style.opacity = '0';
            setTimeout(function() {
                document.querySelector('.login-card').style.transition = 'opacity 0.6s ease';
                document.querySelector('.login-card').style.opacity = '1';
            }, 100);
        });
    </script>
</body>
</html>