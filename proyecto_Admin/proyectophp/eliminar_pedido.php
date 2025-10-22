<?php
    require_once('baseDatos.php');

    if (isset($_POST['codigo'])) {
        $codigo = intval($_POST['codigo']);
        $conn = conectarBD();
        $sql = "DELETE FROM pedidos WHERE codigo = $codigo";
        mysqli_query($conn, $sql);
        mysqli_close($conn);
    }
    header('Location: pedidos.php');
    exit;
?>