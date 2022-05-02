extends Node2D

var nodes_availables;
var rest_nodes = []
var correct = 0;
var incorrect = 0;
var game_state;
# Called when the node enters the scene tree for the first time.
func _ready():
	rest_nodes = get_tree().get_nodes_in_group("zone")
	nodes_availables = getEndPointsTotal()
	for node in rest_nodes:
		node.connect("dropzone_selected", self,"definition_selected")

func getEndPointsTotal():
	var total = 0
	for node in rest_nodes:
		if (!node.startPoint):
			total= total+1
	return total
	
func validateAnswers():
	var answer_nodes = get_tree().get_nodes_in_group("answer")
	for answer in answer_nodes:
		if (answer.id_definition != answer.id_expected ):
			answer.modulate = Color.red
			incorrect +=1;
		else:
			correct +=1;
		

func definition_selected():
	nodes_availables = nodes_availables - 1

func _on_Checkbtn_pressed():
	print(nodes_availables)
	if(nodes_availables == 0):
		validateAnswers()
		if(correct==6):
			game_state="win"
			print(game_state)
			$AcceptDialog.dialog_text = "Cool! Tienes todas las respuestas correctas"
			$AcceptDialog.popup()
		else:
			$AcceptDialog.dialog_text = "Oh no! te has equivocado en "+String(incorrect)
			$AcceptDialog.popup()		
			game_state="lose"
			print(game_state)
	else:
		$AcceptDialog.dialog_text = "No has terminado el juego todavía"
		$AcceptDialog.popup()
		game_state="not_finished"
		


func _on_AcceptDialog_confirmed():
	game_finished()


func game_finished():
	if(game_state=="win"):
		pass
	elif (game_state=="lose"):
		pass
	else:
		$AcceptDialog.hide()
