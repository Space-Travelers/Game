extends Node2D

var nodes_availables;
var rest_nodes = []
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
			return false
	return true
		

func definition_selected():
	print('here')
	nodes_availables = nodes_availables - 1
	print(nodes_availables)
	if(nodes_availables == 0):
		if(validateAnswers()):
			print('Ganaste')
		else:
			print('Perdiste')
