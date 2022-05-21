extends Button


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
	get_tree().change_scene("res://src/scenes/room/room.tscn")


func _on_Button_pressed():
	print(PlayerInfo.email)
	
	pass # Replace with function body.
