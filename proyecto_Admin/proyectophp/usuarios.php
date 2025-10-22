<?php require_once('baseDatos.php'); ?>
<!DOCTYPE html>
<html lang="es">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <!--<link rel="icon" type="image/svg+xml" href="imagenes/icono.svg">-->
   <title>Administración de Productos</title>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
   <link rel="stylesheet" href="css/admin.css">
</head>
<body>
   <mi-cabecera></mi-cabecera>
   
   <br><br><br>
   <h1 style="color:black">Administración de Usuarios</h1>
   <table>
      <tr>
        <th>C&oacute;digo</th>
        <th>Usuario</th>
        <th>Admin</th>
        <th>Nombre</th>
        <th>Direcci&oacute;n</th>
        <th>Tel&eacute;fono</th>
        <th>DNI</th>
        <th>Correo Electr&oacute;nico</th>
        <th>Activo</th>
        <th>Acciones</th>
        <th></th>
        
      </tr>
   <?php
   $resultados = obtenerUsuarios();
   while ($fila = mysqli_fetch_row($resultados)) {
       $pedidos = obtenerPedidosUsuario($fila[0]);
   ?>
      <tr>
        <td><?php echo $fila[0];?></td>
        <td><?php echo $fila[1];?></td>
        
        <td>
            <?php if ($fila[4] == 1) {
                echo "Administrador";
                } elseif ($fila[4] == 0) {
                echo "Usuario";
                }
            ?>
        </td>
        <td><?php echo $fila[5] . " " . $fila[6]; ?></td>
        <td><?php echo $fila[7] . ", " . $fila[10] . ", " . $fila[8] . ", " . $fila[9];?></td>
        <td><?php echo $fila[11];?></td>
        <td><?php echo $fila[12];?></td>
        <td><?php echo $fila[13];?></td>
        <td>
            <?php if ($fila[3] == 1) {
                echo "Activo";
                } elseif ($fila[3] == 0) {
                echo "Inactivo";
                }
            ?>
        </td>
        <td>
            <a href="cambiar_activo.php?codigo=<?php echo $fila[0]; ?>">
                <button class="btn-<?php echo ($fila[3] == 1) ? 'del' : 'act'; ?>">
                    <?php echo ($fila[3] == 1) ? 'Desactivar' : 'Activar'; ?>
                </button>
            </a>
        </td>
        <td>
            <?php if (!mysqli_num_rows($pedidos) > 0) { ?>
                <form method="POST" action="eliminar_usuario.php" style="display:inline;">
                    <input type="hidden" name="codigo" value="<?php echo $fila[0]; ?>">
                    <button type="submit" class="btn-del">Eliminar</button>
                </form>
            <?php } ?>
        </td>
      </tr>
    <?php
    }
    ?>
    </table>
    <br><br><br>
   
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/cabecera.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>