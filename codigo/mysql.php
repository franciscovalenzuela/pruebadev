<?php
class Mysql {
    private $conn;

    public function __construct($servername,$username, $password, $database)
    {
       $this->conn = mysqli_connect($servername, $username, $password, $database);
		// Check connection
		if (!$this->conn) {
		    return "Fallo Conexion: " . mysqli_connect_error();
		}
		return 'Conectado';
    }

    public function desconectar_bd()
    {
        mysqli_close($this->conn);
        return true;
    }

    public function lista($tabla)
    {
       $sql = "SELECT * FROM ".$tabla;
	    $obj=[];
	    if ($result = $this->conn->prepare($sql)){
		    if ($result = $this->conn->query($sql)) {
		    	while ($objeto_resultado = $result->fetch_object()) {
		    		  $obj[] = $objeto_resultado;
		    	}
		    

		    }

		    $result->close();
	    }
	    return $obj;
    }

   public function buscar($tabla, $columna, $valor)
    {
        $sql = "SELECT * FROM ".$tabla." WHERE ".$columna. '='.$valor;
	    $obj=[];
	    if ($result = $this->conn->prepare($sql)){

		    if ($result = $this->conn->query($sql)) {
		    	while ($objeto_resultado = $result->fetch_object()) {
		    		  $obj[] = $objeto_resultado;
		    	}	    
		    }

		    $result->close();
		}
	    return $obj;
    }

     public function checkrut($tabla, $columna, $valor)
    {
        $sql = "SELECT * FROM ".$tabla." WHERE ".$columna. '= "'.$valor.'"';
	    $obj=[];
	    if ($result = $this->conn->prepare($sql)){

		    if ($result = $this->conn->query($sql)) {
		    	while ($objeto_resultado = $result->fetch_object()) {
		    		  $obj[] = $objeto_resultado;
		    	}	    
		    }

		    $result->close();
		}
	    return $obj;
    }

   public function registrar($datos)
    {
    	$sql = "INSERT INTO votaciones (nombre_apellido,alias,rut,email,region_id,comuna_id,candidato_id) VALUES ('".$datos['nombre']."', '".$datos['alias']."', '".$datos['rut']."', '".$datos['email']."', ".$datos['region'].", ".$datos['comuna'].", ".$datos['candidato'].")";
    	$check = false;
    	if ($this->conn->prepare($sql)){

		    if ($this->conn->query($sql)) {
		    	$check = true;
 			}
		}

		if(isset($datos['opcion'])){
			$id = $this->conn->insert_id;
			$sql = "INSERT INTO votacion_opcion (votacion_id,opcion_id) VALUES (?,?)";

			$statement = $this->conn->prepare($sql);
			$check = false;
			foreach ($datos['opcion'] as $value) {
		    	$statement->bind_param("ii",$id,$value);
				 if ($statement->execute()) {
				    	$check = true;
		 		}
				
			}
		}

        return $check;
    } 
}
