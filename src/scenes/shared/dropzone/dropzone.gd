extends Position2D

var selected = false
export var startPoint : bool
export var id_definition : int
export var id_expected: int
var color = Color.transparent
signal dropzone_selected

func _draw():
	var rect = Rect2(Vector2(-85,-33), Vector2(170,66))
	draw_rect(rect, color, true)
	if(startPoint):
		var container = get_node("Rectangle-dropZone")
		remove_child(container)
	
		
func set_id(id):
	id_definition = id
	print(id_definition)
	
func select():
	var rest_nodes = get_tree().get_nodes_in_group("zone")
	for node in rest_nodes:
		print(Global.actual_id_definition)
		if (node.id_definition == Global.actual_id_definition):
			node.deselect()
	modulate = Color.aquamarine 
	selected = true
	emit_signal("dropzone_selected")

	
func deselect():
	if(startPoint):
		color = Color.blue
		
	else:
		modulate = Color.white
	selected = false
	
func selected():
	return selected




