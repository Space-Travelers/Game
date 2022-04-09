extends ColorRect
export var dialogPath = ""
export (float) var textSp = 0.05

var dialog

var phrase_num = 0
var finished = false

func _ready():
	$Timer.wait_time = textSp
	dialog = get_dialog()
	assert(dialog, "Dialog not found")
	next_phrase()

func _process(_delta):
	$Indicator.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			next_phrase()
		else:
			$Text.visible_characters = len($Text.text)
	
	
func get_dialog() -> Array:
	var f = File.new()
	assert(f.file_exists(dialogPath), "File path doesn't exist")
	f.open(dialogPath, File.READ)
	var json = f.get_as_text()
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
		
func next_phrase() -> void:
	if phrase_num >= len(dialog):
		queue_free() #delete dialog box and return
		return
	finished = false 
	$Text.bbcode_text = dialog[phrase_num]["Text"]
	$Text.visible_characters= 0
	
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		
		$Timer.start
		yield($Timer,"timeout")
		
	finished = true
	phrase_num +=1
		
		
		
