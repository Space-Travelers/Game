extends Node2D


var nodes_availables;
var rest_nodes = []
var definitions = [
	{
		'id':1,
		'word': 'citoplasma',
		'definition': 'Es la sustancia que ocupa el interior de la célula. Contiene diversas sustancias de reserva en disolución'
	},
	{
		'id':2,
		'word': 'Membrana Plasmatica',
		'definition': 'Es fundamental, por que aloja sustancias que hacen posible el desarrollo de varias actividades'
	},
	{
		'id':3,
		'word': 'Cloroplasto',
		'definition':'Se encuentran únicamente en las células vegetales. Están limitados por una doble membrana'
	}
]


func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)

# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	$HTTPRequest.request("https://pokeapi.co/api/v2/pokemon/ditto")
	set_information()
	rest_nodes = get_tree().get_nodes_in_group("zone")
	nodes_availables = getEndPointsTotal()	
	for node in rest_nodes:
		node.connect("dropzone_selected", self,"definition_selected")
	

func set_information():
	print('a')
	var word_nodes = get_tree().get_nodes_in_group("word")
	var answer_nodes = get_tree().get_nodes_in_group("answer")	
	
	for definition in definitions:
		for word_node in word_nodes:
			word_node.set_word(definition.word)
			word_node.id_definition = definition.id;
		for answer in answer_nodes:
		 answer.get_node('Definition-container').set_definition(definition.id, definition.definition)


func getEndPointsTotal():
	var total = 0
	for node in rest_nodes:
		if (!node.startPoint):
			total= total+1
	return total
	
func getDefinition(word):
	definitions.map()
	

func validateAnswers():
	var answer_nodes = get_tree().get_nodes_in_group("answer")
	print(answer_nodes)
	for answer in answer_nodes:
		var word_index = answer.get_node('endPoint').id_definition
		var definiton_index = answer.get_node('Definition-container').id_definition
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
