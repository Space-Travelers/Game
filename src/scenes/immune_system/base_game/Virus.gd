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
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
