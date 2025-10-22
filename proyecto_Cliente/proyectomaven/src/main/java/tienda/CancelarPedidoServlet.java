package tienda;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CancelarPedidoServlet")
public class CancelarPedidoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int codigoPedido = Integer.parseInt(request.getParameter("codigoPedido"));
        AccesoBD acceso = AccesoBD.getInstance();
        acceso.cancelarPedido(codigoPedido, 2);
        response.sendRedirect("pedidos_perfil.jsp");
    }
}