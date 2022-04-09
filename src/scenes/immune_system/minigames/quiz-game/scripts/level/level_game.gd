extends Node
#warnings-disable

enum QuestionType { TEXT, IMAGE, VIDEO, AUDIO }

export(Resource) var bd_quiz
export(Color) var color_right
export(Color) var color_wrong
var buttons := []
var index := 0
var correct := 0
var timer := 10
var data := []

onready var question_texts := $question_info/txt_question


func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	for _button in $question_holder.get_children():
		buttons.append(_button)
	for _button in $question_holder2.get_children():
		buttons.append(_button)
	data = json.result
	load_quiz()		
	
func _ready() -> void:
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	$HTTPRequest.request("https://spacback.herokuapp.com/minigames/quiz")
	
func load_quiz() -> void:
	if index >= data.size():
		game_over()
		return
	question_texts.text = str(data[index].question)
	var options = randomize_array(data[index].options)	
	for i in buttons.size():
		buttons[i].text = str(options[i])
		buttons[i].connect("pressed", self, "buttons_answer", [buttons[i]])
		

func buttons_answer(button) -> void:
	if data[index].correct == button.text:
		button.modulate = color_right
		correct += 1
		$audio_correct.play()
	else:
		button.modulate = color_wrong
		$audio_incorrect.play()
		
	_next_question()
		
		
func _next_question() -> void:	
	yield(get_tree().create_timer(1), "timeout")
	for bt in buttons:
		bt.modulate = Color.white
		bt.disconnect("pressed", self, "buttons_answer")
		
	index += 1
	load_quiz()


func randomize_array(array: Array) -> Array:
	randomize()
	var array_temp := array
	array_temp.shuffle()
	return array_temp


func game_over() -> void:
	$game_over.show()
	$game_over/txt_result.text = str(correct, "/", data.size())

func _on_button_restart_pressed():
	get_tree().reload_current_scene()


