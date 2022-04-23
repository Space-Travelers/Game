extends Area2D
var enemies;
export var current_stage: int;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	enemies = get_tree().get_nodes_in_group("enemy")
	print("Current stage: %0d" % current_stage)
	for i in range(enemies.size()):
		if(i==current_stage):
			enemies[i].show()
		else:
			enemies[i].hide()
	
func _input(event):
	if event.is_action_pressed("next_message") and len(get_overlapping_bodies())>0:
		find_and_dialogue()

func find_and_dialogue():
	var dialog = get_node_or_null("DialogBox")
	if dialog:
		dialog.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass