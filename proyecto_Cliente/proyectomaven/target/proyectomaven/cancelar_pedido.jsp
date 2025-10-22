<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="tienda.*" %>
<%
    // Recoger el código del pedido
    String codigoPedidoStr = request.getParameter("codigoPedido");
    if (codigoPedidoStr != null) {
        int codigoPedido = Integer.parseInt(codigoPedidoStr);

        // Acceso a la base de datos
        AccesoBD acceso = AccesoBD.getInstance();
        boolean exito = acceso.cancelarPedido(codigoPedido, 2);

        if (exito) {
%>
            <script>
                alert("Pedido cancelado correctamente.");
                window.location.href = "pedidos_perfil.jsp";
            </script>
<%
        } else {
%>
            <script>
                alert("No se pudo cancelar el pedido.");
                window.location.href = "pedidos_perfil.jsp";
            </script>
<%
        }
    } else {
%>
        <script>
            alert("Código de pedido no válido.");
            window.location.href = "pedidos_perfil.jsp";
        </script>
<%
    }