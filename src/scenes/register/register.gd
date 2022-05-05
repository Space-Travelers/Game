extends Node

onready var drop_menu_down = $genero

var current_avatar_index;


var genero = "M"

# Called when the node enters the scene tree for the first time.
func _ready():

	current_avatar_index = 1;
	add_items()

func add_items():
	drop_menu_down.add_item("Masculino")
	drop_menu_down.add_item("Femenino")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_next_pressed():
	print("IM PRESSED")
	var headers = ["Content-Type: application/json"]
	var body = {"name": $username.get_text(),
  "last_name": $apellido.get_text(),
  "email": $email.get_text(),
  "password": $password.get_text(),
  "age": int($edad.get_text()),
  "level": $nivel.get_text(),
  "gender": $genero.get_text(),
  "school": $Escuela.get_text(),
  "avatar":str(current_avatar_index),
 }
	body = JSON.print(body)
	var error = $HTTPRequest.request("https://spacetravelers.herokuapp.com/player/register",headers, true, HTTPClient.METHOD_POST, body)
	if error != OK:
		print("Error")
	$avatar.show()
	
func _on_genero_item_selected(index):
	var current_select=index		
	if current_select == 0:
		genero="M"
	if current_select == 1:
		genero="F"
	print(genero)
	




var avatars = {
	"avatar1" : "res://assets/UI/astronauts/avatar1.svg",
	"avatar2" :  "res://assets/UI/astronauts/avatar2.svg",
	"avatar3": "res://assets/UI/astronauts/avatar3.svg",
}



# Called when the node enters the scene tree for the first time.
	

func change_img_avatar(file):
	var node = $avatar/astronauta
	node.texture = load(file)

func _on_Button_pressed():
	print("where am i")
		
func _on_register_pressed():
	$avatar.hide()
	get_tree().change_scene("res://src/scenes/login/login.tscn")


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
			print(result)
			if(response_code==200):
				print(body.get_string_from_utf8())
			else:
				print("erro prueba")


func _on_buttonRight_pressed():
	current_avatar_index +=1;
	if (current_avatar_index>3):
		current_avatar_index = 1;
	change_img_avatar(avatars["avatar"+String(current_avatar_index)])


func _on_buttonLeft_pressed():
	current_avatar_index -=1;
	if (current_avatar_index<1):
		current_avatar_index = 3;
	change_img_avatar(avatars["avatar"+String(current_avatar_index)])
	

	
	


	


