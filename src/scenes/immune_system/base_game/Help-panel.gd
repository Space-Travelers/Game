extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_visible(false)
	pass # Replace with function body.

#when help is presssed, pause game
func _on_help_pressed():
	get_tree().paused = true
	set_visible(get_tree().paused)

#function stop pause
func _on_close_pressed():
	get_tree().paused = false
	set_visible(false)

#function for making the pause 
func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible
