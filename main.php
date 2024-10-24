<?php
function Conectar(){
	$connection = mysqli_connect('localhost', 'root', '', 'agro');
	return $connection;
}
?>