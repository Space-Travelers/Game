extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func got_to(path):
	var loader = ResourceLoader.load_interactive(path)
	while true:
		var err = loader.poll()
		if err == ERR_FILE_EOF:
			var resource = loader.get_resource()
			get_tree().get_root().call_deferred('add_child', resource.instance())
			break
		if err == OK:
			var progress = float(loader.get_stage())/loader.get_stage_count()			
