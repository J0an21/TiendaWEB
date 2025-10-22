<?php session_start();

if (isset($_REQUEST['usuario']) && isset($_REQUEST['clave'])) {

/* Aquí comprobariamos que el usuario y la clave son correctos con la base de datos. En el ejemplo suponemos que siempre es correcto. */

	$correcto = true;
	if ($correcto == true ) {
		$_SESSION['userid'] = 1;
		header('Location: ./accedido.php');
	}
	else {
/* Estaría bien informar que el usuario o la clave son incorrectos y no llamar a la página de acceso sin informar de ello.*/
		header('Location: ./login.html');
	}
}
else {
/* Si se ha llamado directamente a este PHP se envía al HTML de login.*/
	header('./login.html');
}
?>