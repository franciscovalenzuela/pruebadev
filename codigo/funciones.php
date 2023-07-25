<?php
//clase mysql con metodos de consulta
require_once('mysql.php');

//archivo de configuracion para conexcion mysql
$json_configuracion = file_get_contents(__DIR__ . '/../cfg/configuracion.json');
$configuracion = json_decode($json_configuracion,true);


//enrutamiento segun funcion enviada en ajax
if (isset($_GET['funcion'])) {
    if ($_GET['funcion'] == "regiones") { echo json_encode(regiones($configuracion)); }
    if ($_GET['funcion'] == "comunas") { echo json_encode(comunas($_GET['regionid'] ,$configuracion)); }
    if ($_GET['funcion'] == "candidatos") { echo json_encode(candidatos($configuracion)); }
    if ($_GET['funcion'] == "checkrut") { echo json_encode(checkrut($_GET['rut_votante'], $configuracion)); }
}

if (isset($_POST['funcion'])) {

	if ($_POST['funcion'] == "registrar") { echo json_encode(registrar($_POST, $configuracion)); }

}


// funciones de consulta mysql, segun peticion ajax

function registrar($datos, $configuracion){
	$mysql_clase = new Mysql($configuracion['configuracion']['servidor'], $configuracion['configuracion']['usuario'], $configuracion['configuracion']['password'], $configuracion['configuracion']['BD']);
	$resultado = $mysql_clase->registrar($datos);
	$mysql_clase->desconectar_bd();
	return $resultado;
}


function regiones($configuracion){
	$mysql_clase = new Mysql($configuracion['configuracion']['servidor'], $configuracion['configuracion']['usuario'], $configuracion['configuracion']['password'], $configuracion['configuracion']['BD']);
	$resultado = $mysql_clase->lista('regiones');
	$mysql_clase->desconectar_bd();
	return $resultado;
}


function comunas($valor, $configuracion){
	$mysql_clase = new Mysql($configuracion['configuracion']['servidor'], $configuracion['configuracion']['usuario'], $configuracion['configuracion']['password'], $configuracion['configuracion']['BD']);
	$resultado = $mysql_clase->buscar('comunas','region_id', $valor);
	$mysql_clase->desconectar_bd();
	return $resultado;
}


function candidatos($configuracion){
	$mysql_clase = new Mysql($configuracion['configuracion']['servidor'], $configuracion['configuracion']['usuario'], $configuracion['configuracion']['password'], $configuracion['configuracion']['BD']);
	$resultado = $mysql_clase->lista('candidatos');
	$mysql_clase->desconectar_bd();
	return $resultado;
}

function checkrut($valor, $configuracion){
	$mysql_clase = new Mysql($configuracion['configuracion']['servidor'], $configuracion['configuracion']['usuario'], $configuracion['configuracion']['password'], $configuracion['configuracion']['BD']);
	$resultado = $mysql_clase->checkrut('votaciones','rut', $valor);
	$mysql_clase->desconectar_bd();
	return $resultado;
}


