package controladores;

import dto.ComplejoDTO;
import entidades.Deportes;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import sesiones.ComplejoFacade;
import sesiones.DeportesFacade;

@WebServlet(name = "ComplejoServlet", urlPatterns = {"/ComplejoServlet"})
public class ComplejoServlet extends HttpServlet {

    @EJB
    private ComplejoFacade complejoFacade;
    
    @EJB
    private DeportesFacade deportesFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String url = "/vistas/ListarComplejos.jsp";

        if (action == null || action.isEmpty()) {
            action = "listar";
        }

        switch (action) {
            case "listar":
                // 1. Pedir a la fachada la lista de DTOs ya procesada.
                List<ComplejoDTO> dtoList = complejoFacade.getComplejosDTO();
                
                // 2. Pedir a la fachada la lista de deportes para los filtros.
                List<Deportes> deportesDisponibles = deportesFacade.findDeportesDisponibles();

                // 3. Poner las listas en el request para que el JSP las pueda usar.
                request.setAttribute("listaComplejosDTO", dtoList);
                request.setAttribute("deportesDisponibles", deportesDisponibles);
                
                break;
            
            default:
                response.sendRedirect(request.getContextPath() + "/ComplejoServlet?action=listar");
                return;
        }

        request.getRequestDispatcher(url).forward(request, response);
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
        return "Servlet para gestionar y listar complejos deportivos";
    }
}
