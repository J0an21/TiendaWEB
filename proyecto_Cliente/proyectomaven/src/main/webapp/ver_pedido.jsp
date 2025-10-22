<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, tienda.*" %>
<%
    int codigoPedido = Integer.parseInt(request.getParameter("codigoPedido"));
    AccesoBD acceso = AccesoBD.getInstance();
    List<Producto> productos = acceso.obtenerProductosPorPedido(codigoPedido);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/svg+xml" href="imagenes/icono.svg">
        <title>Mi tienda</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link rel="stylesheet" href="css/estilos.css">
    </head>
    <body>
        <mi-cabecera></mi-cabecera>
        <br>
        <br><br><br>
        <div class="text-center my-3">
            <a class="btn btn-primary" href="pedidos_perfil.jsp">Volver a mis pedidos</a>
        </div>

        <h2 class="mt-4" style="padding-left:170px">Detalles del Pedido</h2>

        <div class="container">
            <% 
                int count = 0;
                for (Producto p : productos) { 
                    if (count % 2 == 0) { 
            %>
                <div class="row">
            <% 
                    } 
            %>
                    <div class="col-md-6 mb-4">
                        <div class="border rounded p-3 shadow-sm d-flex align-items-center h-100" style="min-width: 300px;">
                            
                            <img src="<%= p.getImagen() %>" class="img-fluid me-3" alt="<%= p.getDescripcion() %>" style="width: 100px; height: auto;">
                            
                            <div class="flex-grow-1 text-center">
                                <h6><b><%= p.getDescripcion() %></b></h6>
                                <p class="mb-0"><%= p.getPrecio() %> €</p>
                            </div>

                            <div>
                                <span class="badge bg-light text-dark p-2">Cantidad: <%= p.getCantidad() %></span>
                            </div>
                        </div>
                    </div>
            <%
                    count++;
                    if (count % 2 == 0 || count == productos.size()) {
            %>
                </div>
            <% 
                    }
                } 
            %>
        </div>
        
        
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