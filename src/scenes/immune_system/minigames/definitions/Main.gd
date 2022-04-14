extends Node2D


var nodes_availables;
var rest_nodes = []
var definitions


func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	definitions = json.result
	print(definitions)
	set_information()

# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	$HTTPRequest.request("https://spacback.herokuapp.com/minigames/definiciones")
	
	rest_nodes = get_tree().get_nodes_in_group("zone")
	nodes_availables = getEndPointsTotal()	
	for node in rest_nodes:
		node.connect("dropzone_selected", self,"definition_selected")
	

func set_information():
	var word_nodes = get_tree().get_nodes_in_group("word")
	var answer_nodes = get_tree().get_nodes_in_group("answer")	
	for definition in definitions:
		for word_node in word_nodes:
			if(word_node.id_definition==0):
				word_node.set_word(definition.word)
				word_node.id_definition = definition.id;
				break;
		for answer in answer_nodes:
			var answer_node = answer.get_node('Definition-container')
			if(answer_node.id_definition == 0):
				answer_node.set_definition(definition.id, definition.definition)
				break;
		for node in rest_nodes:
			if(node.startPoint && node.id_definition == 0):
				node.id_definition = definition.id;
				print(node.id_definition)
				break;
				
				
				


func getEndPointsTotal():
	var total = 0
	for node in rest_nodes:
		if (!node.startPoint):
			total= total+1
	return total
		

func validateAnswers():
	var answer_nodes = get_tree().get_nodes_in_group("answer")
	print(answer_nodes)
	for answer in answer_nodes:
		var word_index = answer.get_node('endPoint').id_definition
		var definiton_index = answer.get_node('Definition-container').id_definition
		print('word index', word_index)
		print('defintion index', definiton_index)
		if (word_index != definiton_index ):
			return false
	return true
		

func definition_selected():
	nodes_availables = nodes_availables - 1
	if(nodes_availables == 0):
		if(validateAnswers()):
			print('Ganaste')
		else:
			print('Perdiste')

