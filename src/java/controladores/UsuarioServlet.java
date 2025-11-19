package controladores;

import entidades.Usuario;
import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import sesiones.UsuarioFacade;
import utils.PasswordUtil;

@WebServlet(name = "UsuarioServlet", urlPatterns = {"/UsuarioServlet"})
public class UsuarioServlet extends HttpServlet {

    @EJB
    private UsuarioFacade usuarioFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Verificación de inyección de EJB
        if (usuarioFacade == null) {
            throw new ServletException("Error crítico: El EJB UsuarioFacade no fue inyectado. Verifique el despliegue de la aplicación.");
        }
        
        String action = request.getParameter("action");
        String url = "index.jsp";

        if (action == null || action.isEmpty()) {
            // Por defecto, si no hay acción, mostramos el login
            action = "mostrar_login";
        }

        switch (action) {
            case "registrar":
                // Lógica de registro (viene de un POST)
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String telefono = request.getParameter("telefono");

                // Verificamos si el email ya existe
                if (usuarioFacade.findByEmail(email) != null) {
                    request.setAttribute("error", "El email '" + email + "' ya está registrado.");
                    // Devolvemos los datos al formulario para comodidad del usuario
                    request.setAttribute("nombre", nombre);
                    request.setAttribute("apellido", apellido);
                    request.setAttribute("email", email);
                    request.setAttribute("telefono", telefono);
                    url = "vistas/registro.jsp";
                } else {
                    // Hasheamos la contraseña ANTES de guardarla
                    String hashedPassword = PasswordUtil.hashPassword(password);

                    Usuario nuevoUsuario = new Usuario();
                    nuevoUsuario.setNombre(nombre);
                    nuevoUsuario.setApellido(apellido);
                    nuevoUsuario.setEmail(email);
                    nuevoUsuario.setPassword(hashedPassword); // Guardamos el hash
                    nuevoUsuario.setTelefono(telefono);
                    
                    usuarioFacade.create(nuevoUsuario);
                    
                    // Usamos la sesión para pasar un mensaje de éxito a la página de login
                    HttpSession session = request.getSession();
                    session.setAttribute("mensaje", "¡Usuario registrado con éxito! Por favor, inicie sesión.");
                    
                    // Redirigimos al servlet que muestra el login (Patrón Post-Redirect-Get)
                    response.sendRedirect(request.getContextPath() + "/UsuarioServlet?action=mostrar_login");
                    return; // Detenemos la ejecución para que la redirección ocurra
                }
                break;

            case "loguear":
                // Lógica de login (viene de un POST)
                String loginEmail = request.getParameter("email");
                String loginPassword = request.getParameter("password");

                Usuario usuario = usuarioFacade.findByEmail(loginEmail);

                // Verificamos si el usuario existe Y si la contraseña coincide
                if (usuario != null && PasswordUtil.checkPassword(loginPassword, usuario.getPassword())) {
                    // ¡Login exitoso! Creamos la sesión.
                    HttpSession session = request.getSession();
                    session.setAttribute("usuarioLogueado", usuario);
                    
                    // Lo redirigimos al servlet que carga los datos de la home
                    response.sendRedirect(request.getContextPath() + "/ManejadorServlet?action=home");
                    return; // Detenemos la ejecución
                    
                } else {
                    // Falló el login: email no encontrado o contraseña incorrecta
                    request.setAttribute("error", "Email o contraseña incorrectos.");
                    url = "vistas/login.jsp";
                }
                break;

            case "logout":
                // Obtenemos la sesión actual sin crear una nueva
                HttpSession sessionToLogout = request.getSession(false);
                if (sessionToLogout != null) {
                    sessionToLogout.invalidate(); // Invalida la sesión y borra sus atributos
                }
                // Redirigimos a la página de login
                response.sendRedirect(request.getContextPath() + "/UsuarioServlet?action=mostrar_login");
                return; // Detenemos la ejecución

            case "mostrar_login":
                // Verificamos si la sesión tiene un mensaje (del registro)
                HttpSession loginSession = request.getSession();
                if (loginSession.getAttribute("mensaje") != null) {
                    // Lo pasamos al request para que el JSP lo muestre
                    request.setAttribute("mensaje", loginSession.getAttribute("mensaje"));
                    // Lo borramos de la sesión para que no se muestre de nuevo
                    loginSession.removeAttribute("mensaje");
                }
                url = "vistas/login.jsp";
                break;
                
            case "mostrar_registro":
                url = "vistas/registro.jsp";
                break;

            default:
                url = "index.jsp";
                break;
        }

        // Hacemos forward a la URL correspondiente (para los GET o POST fallidos)
        RequestDispatcher dispatcher = request.getRequestDispatcher(url);
        dispatcher.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet para manejo de usuarios (Registro, Login, Logout)";
    }
}