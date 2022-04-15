extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file

var dialogues = []
var current_dialogue_id = 0
var is_dialogue_active = false

func _ready():
	$NinePatchRect.visible = false

func play():	
	dialogues = load_dialogue()
	is_dialogue_active = true
	$NinePatchRect.visible = true
	next_line()	
	
func _input(event):
	if not is_dialogue_active:
		return
		
	if event.is_action_pressed("next_message"):
		print("pressed space")
		next_line()
		
func next_line():

	if current_dialogue_id>=len(dialogues):
		$Timer.start()
		$NinePatchRect.visible = false
		Global.tutorial = false
	print("Current index: %0d" % current_dialogue_id)
	if(current_dialogue_id<len(dialogues)):
		$NinePatchRect/Message .text = dialogues[current_dialogue_id]['message']
		current_dialogue_id +=1
	

func load_dialogue():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file,file.READ)
		return parse_json(file.get_as_text())


func _on_Timer_timeout():
	is_dialogue_active=false
	pass # Replace with function body.
