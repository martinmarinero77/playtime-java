package controladores;

import entidades.Cancha;
import entidades.Complejo;
import entidades.Deportes;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import entidades.Cancha;
import entidades.Complejo;
import entidades.Deportes;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import sesiones.CanchaFacade;
import sesiones.ComplejoFacade;
import sesiones.DeportesFacade;

@WebServlet(name = "CanchaServlet", urlPatterns = {"/CanchaServlet"})
public class CanchaServlet extends HttpServlet {

    @EJB
    private CanchaFacade canchaFacade;
    @EJB
    private ComplejoFacade complejoFacade;
    @EJB
    private DeportesFacade deportesFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String url = "/vistas/ListarCanchas.jsp";

        if (action == null || action.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/ComplejoServlet?action=listar");
            return;
        }

        switch (action) {
            case "listarPorComplejo":
                try {
                    String idComplejoStr = request.getParameter("idComplejo");
                    if (idComplejoStr != null && !idComplejoStr.isEmpty()) {
                        
                        Integer idComplejo = Integer.valueOf(idComplejoStr);
                        Complejo complejo = complejoFacade.find(idComplejo);
                        
                        if (complejo != null) {
                            List<Cancha> canchas = canchaFacade.findByIdComplejo(complejo);
                            List<Deportes> deportesDisponibles = deportesFacade.findDeportesByComplejo(complejo);

                            // Formatear fecha de hoy para el calendario
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            String todayDate = sdf.format(new Date());

                            request.setAttribute("complejo", complejo);
                            request.setAttribute("canchas", canchas);
                            request.setAttribute("deportesDisponibles", deportesDisponibles);
                            request.setAttribute("todayDate", todayDate);
                        } else {
                            response.sendRedirect(request.getContextPath() + "/ComplejoServlet?action=listar");
                            return;
                        }
                        
                    } else {
                        response.sendRedirect(request.getContextPath() + "/ComplejoServlet?action=listar");
                        return;
                    }
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/ComplejoServlet?action=listar");
                    return;
                }
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
        return "Servlet para gestionar canchas";
    }
}
