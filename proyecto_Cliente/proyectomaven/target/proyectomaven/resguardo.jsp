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

        if (codigo == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        AccesoBD acceso = AccesoBD.getInstance();
        int codigoInt = codigo;
        UsuarioBD usuario_p = acceso.obtenerUsuario(codigoInt);

    %>
    <br><br><br>
    
    <div class="col-md-4">
        <h3>Resumen</h3>
        <hr>
        <div class="border rounded p-3 shadow-sm">
            <ul style="list-style: none; padding: 0;" id="cart-summary"></ul>
            <hr>
            <p><b>Total: <span id="cart-total">0</span> €</b></p>
            <hr>
        </div>
    </div>
        
    <div>
        <div class="border rounded p-3 shadow-sm">
            <h3>Detalles del Envio</h3>
                <b>Nombre:</b> <%= usuario_p.getNombre() %>
                <b>Apellidos:</b> <%= usuario_p.getApellidos() %>
                <b>Email:</b> <%= usuario_p.getEmail() %>
                <b>Dirección:</b> <%= usuario_p.getDireccion() %>
                <b>Ciudad:</b> <%= usuario_p.getCiudad() %>
                <b>Provincia:</b> <%= usuario_p.getProvincia() %>
        </div>
    </div>

    <button id="comprar" onclick="EnviarCarrito('ProcesarPedido',carrito)" class="pay-btn" disabled>
        <span class="btn-text">Pagar</span>
        <i class="bi bi-credit-card"></i>
    </button>

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
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            mostrarCarritoResumen();
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/cabecera.js"></script>
    <script src="js/footer.js"></script>
    <script src="js/carrito.js"></script>
    <script src="js/libjson.js"></script>
</body>
</html>