package tienda;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/ActualizarPerfilServlet")
public class ActualizarPerfilServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recuperar el código del usuario desde la sesión
        HttpSession session = request.getSession();
        Integer codigo = (Integer) session.getAttribute("codigo");

        if (codigo == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Obtener parámetros del formulario
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String dni = request.getParameter("dni");
        String email = request.getParameter("email");
        String direccion = request.getParameter("direccion");
        String ciudad = request.getParameter("ciudad");
        String provincia = request.getParameter("provincia");
        String cp = request.getParameter("cp");
        String telefono = request.getParameter("telefono");

        // Lógica para actualizar en BD
        AccesoBD acceso = AccesoBD.getInstance();
        boolean actualizado = acceso.actualizarPerfil(
            codigo, nombre, apellidos, dni, email, direccion, ciudad, provincia, cp, telefono
        );

        if (actualizado) {
            response.sendRedirect("index.jsp");
        } else {
            request.setAttribute("error", "No se pudo actualizar el perfil.");
            request.getRequestDispatcher("editar_perfil.jsp").forward(request, response);
        }
    }
}
