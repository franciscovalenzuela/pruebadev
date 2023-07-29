$(document).ready(function () {

	$("input.campo").val("");
	$("input.opciones").prop('checked', false);
	//variable de validacion campos
	var validaciones_ok = [
		{
		    'estado': false,
		    'elemento': '#msgerrornom',
		    'msg':  'No debe estar vacio este campo'
	    },
		{
		    'estado': false,
		    'elemento': '#msgerrorchecked',
		    'msg':  'Favor elegir 2 opciones'
	    },
	    {
		    'estado': false,
		    'elemento': '#msgerroralias',
		    'msg':  'Debe ser mayor 5 caracteres'
	    },
	    {
		    'estado': false,
		    'elemento': '#msgerrormail',
		    'msg':  'Email no valido'
	    },
	    {
		    'estado': false,
		    'elemento': '#msgerrorrut',
		    'msg':  'RUT no valido'
	    }

	];


	//Acciones


     //accion registrar, obtener campos form y validacion
	 $( "#registrar" ).click(function() {

           var myFormData = new FormData();
      
           var formPostData  = $("form").serializeArray();
           
           
           $(formPostData).each(function(i, field){
              myFormData.append(field.name, field.value);
            });
            myFormData.append('funcion', 'registrar');

            var cantidad_ok = 0;
            for (var i = 0; i < validaciones_ok.length; i++) {
            		if(validaciones_ok[i].estado){
            			cantidad_ok++;
            		}else{
            			$(validaciones_ok[i].elemento).html("");
            			$(validaciones_ok[i].elemento).html(validaciones_ok[i].msg);
            		}
            }

            if(cantidad_ok == 5){
		           $.ajax({
		              url: 'codigo/funciones.php',
		              type: 'POST',
		              processData: false,
					  contentType: false,
		              dataType : 'json',
		              data: myFormData,
		              success: function(response){
		               console.log(response);
		                if(response){
		                	alert("Votacion Realizada");
		                	$("input.campo").val("");
		                	$("input.opciones").prop('checked', false);
		                }else{
		                	alert("No se pudo realizar el registro");
		                }
		                  
		              },
		              error: function(){
		              }
		                
		            });
	       	}
            
           
     });


	//accion filtrar comuna segun region
    $('#region').on('change', function() {
    	var idregion = $(this).val();
		$.ajax({
                type: 'GET',
                url: 'codigo/funciones.php',
                data: {
                    funcion: 'comunas',
                    regionid: idregion,
                },
                success: function(data) {
                   var respuesta = JSON.parse(data);
					$('#comuna').empty();
                     for (var i = 0; i < respuesta.length; i++) {
                     $('#comuna').append($('<option>', {value:respuesta[i].id, text:respuesta[i].nombre}));
                    }
                }
    	});

	});





    //consulta ajax: regiones, comunas y candidatos

	$.ajax({
                type: 'GET',
                url: 'codigo/funciones.php',
                data: {
                    funcion: 'regiones'
                },
                success: function(data) {
                    var respuesta = JSON.parse(data);
                    for (var i = 0; i < respuesta.length; i++) {
                     $('#region').append($('<option>', {value:respuesta[i].id, text:respuesta[i].nombre}));
                    }
                    if(respuesta.length > 0){
                        var idregion = $("#region").val();
                        $.ajax({
	                        type: 'GET',
	                        url: 'codigo/funciones.php',
	                        data: {
	                           funcion: 'comunas',
	                           regionid: idregion,
	                        },
	                        success: function(data) {
	                          var respuesta = JSON.parse(data);
	         				  $('#comuna').empty();
	                           for (var i = 0; i < respuesta.length; i++) {
	                            $('#comuna').append($('<option>', {value:respuesta[i].id, text:respuesta[i].nombre}));
	                           }
	                        }
                        });
                    }
                }
    });

  

     $.ajax({
                type: 'GET',
                url: 'codigo/funciones.php',
                data: {
                    funcion: 'candidatos'
                },
                success: function(data) {
                	var respuesta = JSON.parse(data);
                      for (var i = 0; i < respuesta.length; i++) {
                     $('#candidato').append($('<option>', {value:respuesta[i].id, text:respuesta[i].nombre}));
                    }
                }
    });







    //Validaciones 



    $('#nombre').on("keyup",function() {

	  var cantidad_minima = 1;

	   $("#msgerrornom").html("");

	  if(cantidad_minima > $(this).val().length) {
	   $("#msgerrornom").html("No debe estar vacio este campo");
	   validaciones_ok[0].estado= false;
	   validaciones_ok[0].msg= "No debe estar vacio este campo";
	  }else{
	   validaciones_ok[0].estado= true;
	   validaciones_ok[0].msg= "";
	  }
	});


    $('#alias').on('keypress',function(e){
		var keyCode = e.keyCode || e.which;
	 
	    //expresion regular a hasta z o numerico
	    var regex = /^[A-Za-z0-9]+$/;
	 
	    //Validar coincidencia de letras y numeros solamente, segun regex
	    var esvalido = false;
	    esvalido = regex.test(String.fromCharCode(keyCode));
	    return esvalido;
	});

	$('#alias').on("keyup",function() {
	  var cantidad_minima = 5;

	   $("#msgerroralias").html("");
	  if(cantidad_minima > $(this).val().length) {

	   $("#msgerroralias").html("Debe ser mayor 5 caracteres");
	   	validaciones_ok[2].estado= false;
	    validaciones_ok[2].msg= "Debe ser mayor 5 caracteres";
	  }else{
	  	var regex = /^[A-Za-z]+$/;
	 
	    //Validar coincidencia de letras y numeros solamente, segun regex
	    var esvalido = false;
	    esvalido = regex.test($(this).val());

	    if(esvalido){
	    	$("#msgerroralias").html("Alias Debe tener Letras y Numero");
	   		validaciones_ok[2].estado= false;
	    	validaciones_ok[2].msg= "Alias Debe tener Letras y Numero";
	    }else{
	    	validaciones_ok[2].estado= true;
	    	validaciones_ok[2].msg= "";
	    }
	  	
	  }
	});


	//libreria validacion de RUT Chileno para jquery https://github.com/pablomarambio/jquery.rut
	$("#rut").rut().on('rutInvalido', function(e) {
		$(this).val('');
		$("#msgerrorrut").html("");
		$("#msgerrorrut").html("RUT no valido");
		validaciones_ok[4].estado= false;
	    validaciones_ok[4].msg= "RUT no valido";
	});


	//validacion rut y verificacion de rut votante
	$("#rut").rut().on('rutValido', function(e, rut, dv) {
		$("#msgerrorrut").html("");

		var rut = $(this).val();
		$.ajax({
                type: 'GET',
                url: 'codigo/funciones.php',
                data: {
                    funcion: 'checkrut',
                    rut_votante: rut,
                },
                success: function(data) {
                   var respuesta = JSON.parse(data);
					if(respuesta.length > 0){
					    $("#msgerrorrut").html("");
						$("#msgerrorrut").html("RUT ya emitio su voto");
						validaciones_ok[4].estado= false;
	    				validaciones_ok[4].msg= "RUT ya emitio su voto";
					}else{
						validaciones_ok[4].estado= true;
	    				validaciones_ok[4].msg= "";
					}
                }
    	});
	});

   	$('#email').on("keyup",function() {
	  $("#msgerrormail").html("");
	  if(!es_email($(this).val())) {
	   $("#msgerrormail").html("Email no valido");
	    validaciones_ok[3].estado= false;
	    validaciones_ok[3].msg= "Email no valido";
	  }else{
	  	validaciones_ok[3].estado= true;
	    validaciones_ok[3].msg= "";
	  }
	});

	$('.opciones').on('change', function()  {
			var checkd_ct =  $('.opciones:checkbox:checked').length;
			if(checkd_ct < 2){
				$('#msgerrorchecked').html("");
				$('#msgerrorchecked').html("Favor elegir 2 opciones");

				validaciones_ok[1].estado= false;
				validaciones_ok[1].msg= "Favor elegir 2 opciones";
				
			}else{
				$('#msgerrorchecked').html("");
				validaciones_ok[1].estado= true;
				validaciones_ok[1].msg= "";
			}
	});

});

//funciones

function es_email(email) {
  //expresion regular para verificar: caracteres(numerico, simbolo y texto) + un @ + caracteres + punto + caracteres
  var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  return regex.test(email);
}