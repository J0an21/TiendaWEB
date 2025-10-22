<?php
    require_once('baseDatos.php');

    if (isset($_POST['codigo'])) {
        $codigo = intval($_POST['codigo']);
        $conn = conectar();
        $sql = "DELETE FROM usuarios WHERE codigo = $codigo";
        mysqli_query($conn, $sql);
        mysqli_close($conn);
    }
    header('Location: usuarios.php');
    exit;
?>