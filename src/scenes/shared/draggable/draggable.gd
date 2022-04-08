extends Node2D

var selected = false
var rest_point
var rest_nodes = []
signal send_word

export var index : int
export var word : String
export var id_definition : int



# Called when the node enters the scene tree for the first time.
func _ready():
	rest_nodes = get_tree().get_nodes_in_group("zone")
	rest_point = rest_nodes[index].global_position
	rest_nodes[index].select()
	
	

func set_word(definiton_word:String):
	word = definiton_word
	var label = get_node("Label")
	label.text = word
			



func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed( "click"):
		selected = true
		
func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else:
		global_position = lerp(global_position, rest_point, 10 * delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
			var shortest_dist = 75
			for child in rest_nodes:
				var distance = global_position.distance_to(child.global_position)
				if distance < shortest_dist:
					if (!child.selected):
						child.set_id(id_definition)						
						child.select()
						rest_point = child.global_position
						shortest_dist = distance
	
						


