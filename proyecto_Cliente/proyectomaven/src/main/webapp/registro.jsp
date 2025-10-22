<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, tienda.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi tienda</title>
    <link rel="icon" type="image/svg+xml" href="imagenes/icono.svg">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
    <mi-cabecera></mi-cabecera>
    <br><br>
    <br><br>
    <div class="border rounded p-3 shadow-sm container">
        <form action="LoginUsuarioServlet" method="post">
            <h2>Registro de una cuenta nueva</h2>
            <br>
            <h3>Datos personales</h3>
            <hr>
            <div class="form-container">
                <div class="form-section">
                    <label for="nombre_r" class="formulario">Nombre:</label>
                    <input id="nombre_r" type="text" name="nombre_r" class="formulario_in2">
                
                    <label for="apel" class="formulario">Apellidos:</label>
                    <input id="apel" type="text" name="apel" class="formulario_in2">
                
                    <label for="dni" class="formulario">DNI:</label>
                    <input id="dni" type="text" name="dni" class="formulario_in2" maxlength="9">
                
                    <label for="correo" class="formulario">Correo Electrónico:</label>
                    <input id="correo" type="email" name="correo" class="formulario_in2">
                
                    <label for="telf" class="formulario">Teléfono:</label>
                    <input id="telf" type="tel" name="telf" class="formulario_in2" maxlength="9">
                </div>
                
                <div class="form-section">
                    <label for="prov" class="formulario">Provincia:</label>
                    <input id="prov" type="text" name="prov" class="formulario_in2">
                
                    <label for="ciudad" class="formulario">Ciudad:</label>
                    <input id="ciudad" type="text" name="ciudad" class="formulario_in2">
                
                    <label for="direc" class="formulario">Dirección:</label>
                    <input id="direc" type="text" name="direc" class="formulario_in2">
                
                    <label for="cp" class="formulario">Código Postal:</label>
                    <input id="cp" type="tel" name="cp" class="formulario_in2" maxlength="5">
                </div>
            </div>
            <h3>Datos de la cuenta</h3>
            <hr>
            <div class="form-section">
                <label for="nombre_u" class="formulario">Nombre de usuario:</label>
                <input id="nombre_u" type="text" name="nombre_u" class="formulario_in2">
                
                <label for="pass" class="formulario">Contraseña:</label>
                <input id="pass" type="password" name="pass" class="formulario_in2">
                
                <label for="n_pass" class="formulario">Repite la Contraseña:</label>
                <input id="n_pass" type="password" name="n_pass" class="formulario_in2">
            </div>
            <hr>
           <input type="submit" class="btn btn-primary btn-space d-block mx-auto" value="Registrarse">

        </form>
    </div>
    <br>
    <br>
    <br>
    <br>
    <mi-footer></mi-footer>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/cabecera.js"></script>
    <script src="js/footer.js"></script>
</body>
</html>
