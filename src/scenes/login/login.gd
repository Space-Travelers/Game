extends Node
export var name_scene = ""

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	print(body.get_string_from_utf8())
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)  
	if result == HTTPRequest.RESULT_SUCCESS:
		if(response_code==200):
			print(body.get_string_from_utf8())
			if(body.get_string_from_utf8() == '["Player not logged"]'):
				$alerta.show()	
			else:
				get_tree().change_scene("res://src/scenes/room/room.tscn")
				
		else:
			print("errot")
	

func _on_TextureButton_pressed():
	var headers = ["Content-Type: application/json"]
	var body = { "email": $username.get_text(), "password": $password.get_text()}
	body = JSON.print(body)
	var error = $HTTPRequest.request("https://spacetravelers.herokuapp.com/player/login",headers, true, HTTPClient.METHOD_POST, body)
	
	if error != OK:
		push_error("un error ocurrió con el request")
	else:
		PlayerInfo.user_name = $username.get_text().split("@")[0]
		PlayerInfo.email =  $username.get_text()
		

	


func _on_LinkButton_button_up():
	get_tree().change_scene("res://src/scenes/register/register.tscn")
