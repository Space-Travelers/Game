extends Sprite

var id_definition : int
var definition


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_definition(id, definition):
	var label = get_node("RichTextLabel")
	label.text = definition
	id_definition = id;
