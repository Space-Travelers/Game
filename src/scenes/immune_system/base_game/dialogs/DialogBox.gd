extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file

var dialogues = []
#Types of dialogues 
var tutorials = []
var dialogues_messages = []
var dialog_index = -1
var active_dialog = false

func _ready():
	$NinePatchRect.visible = false


func play():	
	if active_dialog:
		return 
	dialogues = load_dialog()
	active_dialog = true
	$NinePatchRect.visible = true
	next_line()
	
	
func _input(event):
	if not active_dialog:
		return		
	if event.is_action_pressed("next_message") and Global.dialog_zone == "tutorial":
		print("pressed space")
		next_line()
		
func next_line():
	dialog_index +=1
	if Global.tutorial:
		dialogues_messages = dialogues[0]["message"]
	
	if dialog_index>=len(dialogues_messages):
		$Timer.start()
		$NinePatchRect.visible = false
		Global.tutorial = false
	print("len of dialog %0d" % len(dialogues_messages))
	
	if dialog_index<len(dialogues_messages):
		$NinePatchRect/Message.text = dialogues_messages[dialog_index]
		print("Current index: %0d" % dialog_index)

		
	

func load_dialog():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file,file.READ)
		return parse_json(file.get_as_text())


func _on_Timer_timeout():
	active_dialog=false
	pass # Replace with function body.
