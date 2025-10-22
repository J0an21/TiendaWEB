<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, tienda.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mi tienda - Listado de productos</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/svg+xml" href="imagenes/icono.svg">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
    <mi-cabecera></mi-cabecera>

    <%
        int categoria = 1;
        AccesoBD con = AccesoBD.getInstance();
        List<ProductoBD> productos = con.obtenerProductosBD(categoria);
    %>

    <div class="container-fluid mt-5" style="padding-top: 100px;">
        <div class="row">
            <!-- Filtros -->
            <div class="col-lg-3 mb-4">
                <div class="border rounded p-3 shadow-sm bg-light">
                    <h5>Buscar juego</h5>
                    <input type="text" id="buscador" class="form-control mb-2" placeholder="Nombre del juego">

                    <h5 class="mt-3">Tipo de Juego</h5>
                    <div class="form-check">
                        <input class="form-check-input filtro-tipo" type="checkbox" value="Aventura" id="aventura">
                        <label class="form-check-label" for="aventura">Aventura</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input filtro-tipo" type="checkbox" value="Deportes" id="deportes">
                        <label class="form-check-label" for="deportes">Deportes</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input filtro-tipo" type="checkbox" value="Estrategia" id="estrategia">
                        <label class="form-check-label" for="estrategia">Estrategia</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input filtro-tipo" type="checkbox" value="Puzles" id="puzles">
                        <label class="form-check-label" for="puzles">Puzles</label>
                    </div>

                    <h5 class="mt-3">Precio</h5>
                    <input type="number" id="precio-min" placeholder="Precio mínimo" class="form-control mb-2">
                    <input type="number" id="precio-max" placeholder="Precio máximo" class="form-control mb-2">

                    <h5 class="mt-3">Saga</h5>
                    <select id="filtro-saga" class="form-control mb-2">
                        <option value="">Todos</option>
                        <option value="Sonic">Sonic</option>
                        <option value="FIFA">FIFA</option>
                        <option value="Mario">Mario</option>
                        <option value="Inazuma Eleven">Inazuma Eleven</option>
                        <option value="Profesor Layton">Profesor Layton</option>
                        <option value="Pokemon">Pokemon</option>
                    </select>

                    <h5 class="mt-3">Creador</h5>
                    <select id="filtro-creador" class="form-control mb-3">
                        <option value="">Todos</option>
                        <option value="Nintendo">Nintendo</option>
                        <option value="EA Sports">EA Sports</option>
                        <option value="Level-5">Level-5</option>
                        <option value="Sega">Sega</option>
                        <option value="Game Freak">Game Freak</option>
                    </select>

                    <button class="btn btn-primary w-100">Aplicar Filtros</button>
                </div>
            </div>

            <!-- Productos -->
            <div class="col-lg-9">
                <div class="row"> <!-- Añadido contenedor con clase row -->
                    <% for (ProductoBD producto : productos){
                        int codigo=producto.getCodigo();
                        String nombre=producto.getNombre();
                        float precio=producto.getPrecio();
                        int existencias=producto.getStock();
                        String imagen=producto.getImagen();
                    %>
                    <div class="col-lg-4 col-md-6 col-sm-12 text-center mb-4">
                        <div class="border rounded p-3 shadow-sm"> 
                            <img src="<%= imagen %>" class="img-fluid" alt="<%= nombre %>">
                            <h6><b><%= nombre %></b></h6>
                            <p><%= precio %> €</p>
                            <% if (existencias > 0) { %>
                                <div class="mb-2">
                                    <input type="number" id="cantidad-<%= codigo %>" class="form-control text-center" value="1" min="1" max="<%= existencias %>" style="width: 80px; display: inline-block;">
                                </div>
                                <button class="btn btn-primary btn-space"
                                    onclick='anyadirCarrito(
                                        "<%= codigo %>",
                                        "<%= nombre %>",
                                        "<%= imagen %>",
                                        parseInt(document.getElementById("cantidad-<%= codigo %>").value),
                                        "<%= precio %>",
                                        "<%= existencias %>")'>
                                    Comprar
                                </button>
                            <% } else { %>
                                <div class="mb-2">
                                    <input type="number" id="cantidad-<%= codigo %>" class="form-control text-center" value="1" style="width: 80px; display: inline-block;" disabled>
                                </div>
                                <button class="btn btn-tertiary btn-space" disabled>Agotado</button>
                            <% } %>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
    <%
        String loginStatus = (String) session.getAttribute("loginStatus");
        String usuario = (String) session.getAttribute("usuario");
    %>
    <script>
        window.loginStatus = "<%= loginStatus != null ? loginStatus : ";" %>";
        window.nombreUsuario = "<%= usuario != null ? usuario : ";" %>";
    </script>
    <%

    %>
    <br><br><br><br>
    <mi-footer></mi-footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/cabecera.js"></script>
    <script src="js/footer.js"></script>
    <script src="js/carrito.js"></script>
</body>
</html>