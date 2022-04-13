extends Node

signal dropzone_deselected

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_Global_dropzone_deselected():
	print('a')
	pass # Replace with function body.


func deselect_dropzone():
	emit_signal('dropzone_deselected')
