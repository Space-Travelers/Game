extends Node

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	print(body.get_string_from_utf8())
	if result == HTTPRequest.RESULT_SUCCESS:
		if(response_code==200):
			print(body.get_string_from_utf8())
		else:
			print("errot")
	

func _on_TextureButton_pressed():
	var headers = ["Content-Type: application/json"]
	var body = { "email": $username.get_text(), "password": $password.get_text()}
	body = JSON.print(body)
	var error = $HTTPRequest.request("https://spacetravelers.herokuapp.com/player/login",headers, true, HTTPClient.METHOD_POST, body)
	if error != OK:
		push_error(" An error occured in  the HTTP request")
	


