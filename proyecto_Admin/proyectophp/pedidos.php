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
   <h1 style="color:black">Administración de Pedidos</h1>
   <table>
      <tr>
        <th>C&oacute;digo</th>
        <th>Persona</th>
        <th>Fecha</th>
        <th>Importe</th>
        <th>Estado</th>
        <th>Acciones</th>
        <th></th>
      </tr>
   <?php
   $resultados = obtenerPedidos();
   while ($fila = mysqli_fetch_row($resultados)) {
    ?>
        <tr>
            <td><?php echo $fila[0];?></td>
            <td>
                <?php
                    $resultadoUsuario = obtenerUsuarioCod($fila[1]);
                    $usuario = mysqli_fetch_row($resultadoUsuario);
                    echo $usuario[1];
                ?>
            </td>
            <td><?php echo $fila[2];?></td>
            <td><?php echo $fila[3];?></td>
            <td>
                <?php
                    if ($fila[4] == 1) {
                    echo "Pendiente";
                    } elseif ($fila[4] == 2) {
                    echo "Cancelado";
                    } elseif ($fila[4] == 3) {
                    echo "Enviado";
                    } elseif ($fila[4] == 4) {
                    echo "Entregado";
                    }
                ?>
            </td>
            <td>
                <a href="detalle.php?codigo_pedido=<?php echo $fila[0]; ?>">
                    <button class="btn-space">Ver Detalles</button>
                </a>
                <form method="POST" action="cambiar_estado_pedido.php" style="display:inline;">
                    <input type="hidden" name="codigo" value="<?php echo $fila[0]; ?>">
                    <select name="estado" class="form-select form-select-sm" style="width:auto;display:inline;">
                        <option value="1" <?php if ($fila[4]==1) echo 'selected'; ?>>Pendiente</option>
                        <option value="2" <?php if ($fila[4]==2) echo 'selected'; ?>>Cancelado</option>
                        <option value="3" <?php if ($fila[4]==3) echo 'selected'; ?>>Enviado</option>
                        <option value="4" <?php if ($fila[4]==4) echo 'selected'; ?>>Entregado</option>
                    </select>
                    <button type="submit" class="btn btn-primary btn-sm">Guardar</button>
                </form>
            </td>
            <td>
                <?php if ($fila[4] == 2) { ?>
                    <form method="POST" action="eliminar_pedido.php" style="display:inline;">
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
   <script src="js/cabecera.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>