<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, tienda.*" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/svg+xml" href="imagenes/icono.svg">
    <title>Mi tienda</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/tabla.css">
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
    <mi-cabecera></mi-cabecera>
    <br><br><br><br>
    <div class="text-center my-3">
            <a class="btn btn-primary" href="perfil.jsp">Volver al perfil</a>
        </div>
    <%
        Integer codigo = (Integer) session.getAttribute("codigo");
        if (codigo == null) {
            System.out.println("No hay código de usuario en la sesión.");
        } else {
            System.out.println("Código de usuario en sesión: " + codigo);
        }
        AccesoBD acceso = AccesoBD.getInstance();
        int codigoInt = codigo;
        List <PedidoBD> pedidos = acceso.obtenerPedidosBD(codigoInt);
    %>
    <table>
        <thead>
            <tr>
                <th>Código</th>
                <th>Fecha</th>
                <th>Importe</th>
                <th>Estado</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <% for (PedidoBD pedido : pedidos) {
                int cod = pedido.getCodigo();
                String fecha = pedido.getFecha().toString();
                float importe = pedido.getImporte().floatValue();
                int estado = pedido.getEstado();
            %>
            <tr>
                <td><%= cod %></td>
                <td><%= fecha %></td>
                <td><%= importe %> €</td>
                <td><% if(estado == 1) { %>Pendiente<% } else if(estado == 2) { %>Cancelado<% } else if(estado == 3) { %>Enviado<% } else { %>Entregado<% } %></td>
                <td>
                    <div style="display: flex; gap: 10px;">
                        <form action="ver_pedido.jsp" method="post">
                            <input type="hidden" name="codigoPedido" value="<%= cod %>">
                            <button type="submit" class="btn btn-primary">Ver Detalles</button>
                        </form>

                        <% if(estado == 1) { %>
                        <form action="CancelarPedidoServlet" method="post">
                            <input type="hidden" name="codigoPedido" value="<%= cod %>">
                            <button type="submit" class="btn btn-danger">Cancelar Pedido</button>
                        </form>
                        <% } %>
                    </div>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <%
        String loginStatus = (String) session.getAttribute("loginStatus");
        String usuario = (String) session.getAttribute("usuario");
    %>
    <script>
        window.loginStatus = "<%= loginStatus %>";
        window.nombreUsuario = "<%= usuario %>";
    </script>
    <br><br><br>
    <mi-footer></mi-footer>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/cabecera.js"></script>
    <script src="js/footer.js"></script>
    <script src="js/libjson.js"></script>
</body>
</html>
