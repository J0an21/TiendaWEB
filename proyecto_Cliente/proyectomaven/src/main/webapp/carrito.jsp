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
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
    <mi-cabecera></mi-cabecera>
    <%
        Integer codigo = (Integer) session.getAttribute("codigo");
        AccesoBD acceso = AccesoBD.getInstance();
        int codigoInt = codigo;
        UsuarioBD usuario_p = acceso.obtenerUsuario(codigoInt);
    %>
    <br><br><br>
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8">
                <h3>Carrito de Compras</h3>
                <hr>
                <ul id="cart-items" class="list-group"></ul> <!-- Contenedor para los productos del carrito -->
            </div>

            <div class="col-md-4">
                <h3>Resumen</h3>
                <hr>
                <div class="border rounded p-3 shadow-sm" style="background-color: #343a40;">
                    <ul style="list-style: none; padding: 0;" id="cart-summary"></ul>   
                    <hr>
                    <p><b>Total: <span id="cart-total">0</span> €</b></p>
                    <hr>
                    <button id="comprar" class="pay-btn" disabled data-bs-toggle="modal" data-bs-target="#checkoutModal">
                        <span class="btn-text">Pagar</span>
                        <i class="bi bi-credit-card"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="checkoutModal" tabindex="-1" aria-labelledby="checkoutModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="checkoutModalLabel">Datos de Envío y Pago</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
        </div>
        <div class="modal-body">
            <p><strong>Nombre completo:</strong> <%= usuario_p.getNombre() %> <%= usuario_p.getApellidos() %></p>

            <div class="mb-3">
            <label for="direccion" class="form-label">Domicilio</label>
            <input type="text" class="form-control" id="direccion" value="<%= usuario_p.getDireccion() %>" placeholder="Calle, número, piso...">
            </div>

            <div class="row">
            <div class="col-md-6 mb-3">
                <label for="cp" class="form-label">Código Postal</label>
                <input type="text" class="form-control" id="cp" value="<%= usuario_p.getCp() %>">
            </div>
            <div class="col-md-6 mb-3">
                <label for="ciudad" class="form-label">Ciudad</label>
                <input type="text" class="form-control" id="ciudad" value="<%= usuario_p.getCiudad() %>">
            </div>
            </div>

            <div class="mb-3">
            <label for="provincia" class="form-label">Provincia</label>
            <input type="text" class="form-control" id="provincia" value="<%= usuario_p.getProvincia() %>">
            </div>

            <h6>Datos de la Tarjeta</h6>
            <div class="mb-3">
            <label for="numeroTarjeta" class="form-label">Número de Tarjeta</label>
            <input type="text" class="form-control" id="numeroTarjeta" maxlength="19" placeholder="XXXX XXXX XXXX XXXX">
            </div>
            <div class="row">
            <div class="col">
                <label for="fechaExp" class="form-label">Fecha Expiración</label>
                <input type="text" class="form-control" id="fechaExp" placeholder="MM/AA">
            </div>
            <div class="col">
                <label for="cvv" class="form-label">CVV</label>
                <input type="text" class="form-control" id="cvv" maxlength="4" placeholder="123">
            </div>
            </div>
        </div>

        <div class="modal-footer" style="display: flex; align-items: center; justify-content: center;">
            <button type="button" class="btn btn-success" onclick="tramitarPedido()">Tramitar Pedido</button>
        </div>
        </div>
    </div>
    </div>

    <%
        String loginStatus = (String) session.getAttribute("loginStatus");
        String usuario = (String) session.getAttribute("usuario");
    %>
    <script>
        window.loginStatus = "<%= loginStatus %>";
        window.nombreUsuario = "<%= usuario %>";
    </script>
    

    <br>
    <mi-footer></mi-footer>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/cabecera.js"></script>
    <script src="js/footer.js"></script>
    <script src="js/carrito.js"></script>
    <script src="js/libjson.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
