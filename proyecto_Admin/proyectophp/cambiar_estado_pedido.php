<?php
    require_once('baseDatos.php');
    if (isset($_POST['codigo']) && isset($_POST['estado'])) {
        $codigo = intval($_POST['codigo']);
        $estado = intval($_POST['estado']);
        $conn = conectar();
        $sql = "UPDATE pedidos SET estado = $estado WHERE codigo = $codigo";
        mysqli_query($conn, $sql);
        desconectar($conn);
    }
    header('Location: pedidos.php');
    exit;
?>