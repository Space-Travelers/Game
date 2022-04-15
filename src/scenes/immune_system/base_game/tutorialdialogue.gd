extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.tutorial:
		self.visible = true
	else:
		self.visible = false
	pass # Replace with function body.

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
