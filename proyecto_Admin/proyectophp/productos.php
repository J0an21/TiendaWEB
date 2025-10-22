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
   <h1 style="color:black">Administración de Productos</h1>
   <table>
      <tr>
        <th>C&oacute;digo</th>
        <th>Imagen</th>
        <th>Nombre</th>
        <th>Precio</th>
        <th>Existencias</th>
        <th>Categor&iacute;a</th>
        <th>Acciones</th>
        <th>
            <div class="btn-container">
               <button class="btn-space">Añadir Producto</button>
            </div>
         </th>
      </tr>
   <?php
   $resultados = obtenerProductos();
   while ($fila = mysqli_fetch_row($resultados)) {
      $productos = obtenerProductoPedido($fila[0]);
   ?>
      <tr id="fila-<?php echo $fila[0]; ?>">
         <form method="POST" action="actualizar_producto.php" class="form-producto">
            <td><?php echo $fila[0];?></td>
            <td><img src="<?php echo $fila[4];?>" alt="Imagen de <?php echo $fila[1];?>" style="max-width: 100px;"></td>
            <td><?php echo $fila[1];?></td>
            <td class="precio">
               <span><?php echo $fila[2];?></span>
               <input type="number" name="precio" value="<?php echo $fila[2];?>" style="display:none; width:80px;" step="0.01" min="0">
            </td>
            <td class="existencias">
               <span><?php echo $fila[3];?></span>
               <input type="number" name="existencias" value="<?php echo $fila[3];?>" style="display:none; width:80px;" min="0">
            </td>
            <td><?php echo $fila[5];?></td>
            <td>
               <button type="button" class="btn-editar">Editar</button>
               <button type="submit" class="btn-guardar" style="display:none;">Guardar</button>
               <input type="hidden" name="codigo" value="<?php echo $fila[0]; ?>">
            </td>
            <td>
               <?php if (!mysqli_num_rows($productos) > 0) { ?>
               <form method="POST" action="eliminar_producto.php" style="display:inline;">
                  <input type="hidden" name="codigo" value="<?php echo $fila[0]; ?>">
                  <button type="submit" class="btn-del">Eliminar</button>
               </form>
               <?php } ?>
            </td>
         </form>
      </tr>
   <?php
   }
   ?>
   </table>
   <br><br><br>
   <script src="js/cabecera.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
   <script>
      document.querySelectorAll('.btn-editar').forEach(btn => {
      btn.addEventListener('click', function() {
         const row = btn.closest('tr');
         row.querySelector('.precio span').style.display = 'none';
         row.querySelector('.precio input').style.display = '';
         row.querySelector('.existencias span').style.display = 'none';
         row.querySelector('.existencias input').style.display = '';
         btn.style.display = 'none';
         row.querySelector('.btn-guardar').style.display = '';
      });
      });
   </script>
</body>
</html>