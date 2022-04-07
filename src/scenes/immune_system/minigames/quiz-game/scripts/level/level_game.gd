extends Node
#warnings-disable

enum QuestionType { TEXT, IMAGE, VIDEO, AUDIO }

export(Resource) var bd_quiz
export(Color) var color_right
export(Color) var color_wrong

var buttons := []
var index := 0
var quiz_shuffle := []
var correct := 0
var timer := 10

onready var question_texts := $question_info/txt_question
onready var question_image := $question_info/image_holder/question_Image
onready var question_video := $question_info/image_holder/question_video
onready var question_audio := $question_info/image_holder/question_audio

func _ready() -> void:
	for _button in $question_holder.get_children():
		buttons.append(_button)
	for _button in $question_holder2.get_children():
		buttons.append(_button)
	
	quiz_shuffle = randomize_array(bd_quiz.bd)
	load_quiz()		

		
func load_quiz() -> void:
	if index >= bd_quiz.bd.size():
		game_over()
		return
	
	question_texts.text = str(quiz_shuffle[index].question_info)
	
	var options = randomize_array(bd_quiz.bd[index].options)	
	for i in buttons.size():
		buttons[i].text = str(options[i])
		buttons[i].connect("pressed", self, "buttons_answer", [buttons[i]])
		

func buttons_answer(button) -> void:
	if bd_quiz.bd[index].correct == button.text:
		button.modulate = color_right
		correct += 1
		$audio_correct.play()
	else:
		button.modulate = color_wrong
		$audio_incorrect.play()
		
	_next_question()
		
		
func _next_question() -> void:
	
	timer = 10
	
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
	$game_over/txt_result.text = str(correct, "/", bd_quiz.bd.size())

func _on_button_restart_pressed():
	get_tree().reload_current_scene()


