extends Button
export var stastistic="health";

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		if(response_code==200):
			get_tree().change_scene("res://src/scenes/room/room.tscn")	
		else:
			print("error fffff")
	pass


func _on_Button_pressed():
	Global.coins = 0
	Global.level = 1
	var headers = ["Content-Type: application/json"]
	print(PlayerInfo.email)
	var body = {
  "email": PlayerInfo.email,
  "statistic": stastistic,
  "points": 20
	}
	body = JSON.print(body)
	var error = $HTTPRequest.request("https://spacetravelers.herokuapp.com/player/statistics",headers, true, HTTPClient.METHOD_POST, body)
	print("request completed")
