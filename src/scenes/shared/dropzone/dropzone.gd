extends Position2D

var selected = false
export var startPoint : bool
signal dropzone_selected
var id_definition : int

func _draw():
	var rect = Rect2(Vector2(-85,-33), Vector2(170,66))
	draw_rect(rect, Color.transparent, true)
	if(startPoint):
		var container = get_node("Rectangle-dropZone")
		remove_child(container)
		
func set_id(id):
	id_definition = id
	
func select():
	modulate = Color.green
	selected = true
	emit_signal("dropzone_selected")

	
func deselect():
	modulate = Color.white
	selected = false
	
func selected():
	return selected

