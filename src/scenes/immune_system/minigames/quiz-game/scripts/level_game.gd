extends Node
#warnings-disable
export var parentScene = "";
enum QuestionType { TEXT, IMAGE, VIDEO, AUDIO }

export(Resource) var bd_quiz
export(Color) var color_right
export(Color) var color_wrong
export var nextScene: String = ""
var buttons := []
var index := 0
var correct := 0
var timer := 10
var data := []

onready var question_texts := $question_info/txt_question


func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	for _button in $question_holder.get_children():
		buttons.append(_button)
	for _button in $question_holder2.get_children():
		buttons.append(_button)
	data = json.result
	load_quiz()		
	
func _ready() -> void:
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	$HTTPRequest.request("https://spacetravelers.herokuapp.com/minigames/quiz")
	
	
func load_quiz() -> void:
	if index >= data.size():
		game_over()
		return
	question_texts.text = str(data[index].question)
	var options = randomize_array(data[index].options)
	print(options)	
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
	if correct == 4: 
		$game_over/button_restart.text = "siguiente"
		$game_over/txt_info2.text=""
	else:
		if Global.coins == 0:
			$game_over/txt_info2.text = "Te has quedado sin glóbulos rojos :(\n\nRecolecta más para poder seguir jugando"
			$game_over/button_restart.text = "recolectar glóbulos rojos"
		else:
			Global.coins = Global.coins - 1
			$game_over/txt_info2.text = "Oh, no! Has perdido un glóbulo rojo \n\nGlóbulos rojos restantes: %0d\nVuelve a intentar" % (Global.coins)
			$game_over/button_restart.text = "volver a jugar"	
	


		

func _on_button_restart_pressed():
	print("tengo... %0d monedas"%Global.coins)
	if correct == 4:
		Global.lost_challenge = false
		Global.scan = false
		get_tree().change_scene(nextScene)
	elif (Global.coins>0):
		get_tree().reload_current_scene()
	elif Global.coins == 0:
		print("oops 0 monedas")
		Global.reset_player = true
		get_tree().change_scene(parentScene)

	
	


