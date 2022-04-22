extends Node2D
export var next_stage : String;
var nodes_availables;
var nodes_start;
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
	$HTTPRequest.request("https://spacetravelers.herokuapp.com/minigames/definiciones")
	
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
	if (nodes_availables > 0):
		nodes_availables = nodes_availables - 1
		print(nodes_availables)
	else: 
		nodes_start = get_tree().get_nodes_in_group("start")
		print(nodes_start.size())
		
		
	
func _on_Checkbtn_pressed():
	if(nodes_availables == 0):
		if(validateAnswers()):
			print('Ganaste')
			Global.lost_challenge = false
			get_tree().change_scene("res://src/scenes/immune_system/base_game/stage_2.tscn")
		else:
			if (Global.coins - 1 > -1):
				Global.coins = Global.coins - 1
			elif Global.coins == 0:
				print("oops 0 monedas")
				Global.reset_position = true
			print('Perdiste')
			Global.lost_challenge = true
			get_tree().change_scene("res://src/scenes/immune_system/base_game/stage_1.tscn")
			
			print(Global.coins)
	else:
		print("Aún hay nodos")

