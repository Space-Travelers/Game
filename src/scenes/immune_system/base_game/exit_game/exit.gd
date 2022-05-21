extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	$TextureButton.hide()
	$Panel.show()
	$Panel/Panel.show()
	pass # Replace with function body.


func _on_Ok_pressed():
	$Panel.hide()
	$TextureButton.show()
	



func _on_Cancelar_pressed():
	get_tree().change_scene("res://src/scenes/room/room.tscn")
	pass # Replace with function body.
