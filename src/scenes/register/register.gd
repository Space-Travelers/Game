extends Node

onready var drop_menu_down = $genero



var genero = "M"

# Called when the node enters the scene tree for the first time.
func _ready():
	add_items()

func add_items():
	drop_menu_down.add_item("Masculino")
	drop_menu_down.add_item("Femenino")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_genero_item_selected(index):
	var current_select=index		
	if current_select == 0:
		genero="M"
	if current_select == 1:
		genero="F"
	print(genero)
	
func _on_Button_pressed():
	var headers = ["Content-Type: application/json"]
	var body = {"name": $username.get_text(),
  "last_name": $apellido.get_text(),
  "email": $email.get_text(),
  "password": $password.get_text(),
  "age": 0,
  "level": $nivel.get_text(),
  "gender": $genero.get_text(),
  "school": $Escuela.get_text()}
		
	body = JSON.print(body)
	var error = $HTTPRequest.request("https://spacetravelers.herokuapp.com/player/register",headers, true, HTTPClient.METHOD_POST, body)
	if error != OK:
		push_error(" An error occured in  the HTTP request")
	


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
		if result == HTTPRequest.RESULT_SUCCESS:
			if(response_code==200):
				print(body.get_string_from_utf8())
			else:
				print("errot")
	


