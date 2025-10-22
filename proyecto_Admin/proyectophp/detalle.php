<?php

require_once('baseDatos.php');

if (!isset($_GET['codigo_pedido'])) {
    echo "No se ha especificado el pedido.";
    exit;
}

$codigo_pedido = intval($_GET['codigo_pedido']);
$resultado = detallesPedido($codigo_pedido);
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Detalle del Pedido</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
   <link rel="stylesheet" href="css/admin.css">
</head>
<body>
    <mi-cabecera></mi-cabecera>
   
   <br><br><br>
    <h2>Detalle del Pedido #<?php echo $codigo_pedido; ?></h2>
    <table>
        <tr>
            <th>Imagen</th>
            <th>Nombre</th>
            <th>Cantidad</th>
            <th>Precio</th>
        </tr>
        <?php while ($fila = mysqli_fetch_row($resultado)) { ?>
            <tr>
                <td>
                    <img src="<?php echo htmlspecialchars($fila[0]); ?>" alt="Imagen" style="width:80px; height:auto;">
                </td>
                <td><?php echo htmlspecialchars($fila[1]); ?></td>
                <td><?php echo htmlspecialchars($fila[2]); ?></td>
                <td><?php echo htmlspecialchars($fila[3]); ?></td>
            </tr>
        <?php } ?>
    </table>
    <a href="pedidos.php" class="btn btn-secondary">Volver a pedidos</a>

    <script src="js/cabecera.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>