extends Node2D

var nodes_availables;
var rest_nodes = []
var correct = 0;
var incorrect = 0;
var game_state;
var total_nodes=0
var startpoint_ids = []

# Called when the node enters the scene tree for the first time.
func _ready():
	rest_nodes = get_tree().get_nodes_in_group("zone")
	total_nodes = getEndPointsTotal();
	set_nodes_id_in_rest()
	nodes_availables = total_nodes;
	for node in rest_nodes:
		node.connect("dropzone_selected", self,"definition_selected",[node])

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
		

func definition_selected(node):
	if(node.startPoint):
		reset_nodes(node.id_definition)
		if !startpoint_ids.has(node.id_definition):
			startpoint_ids.append(node.id_definition)
			print(startpoint_ids)
			var new_value= nodes_availables +1;
			nodes_availables = new_value if new_value <= total_nodes else nodes_availables
		
		
	if(get_origin(node.id_definition)=="startPoint" && !node.startPoint):
		if startpoint_ids.has(node.id_definition):
			startpoint_ids.erase(node.id_definition)			
		nodes_availables-=1;
	print(nodes_availables)	

## verify if the word dragged comes from a endpoint and not a starpoint
func get_origin(id):
	var cont=0
	for node in rest_nodes:
		if(node.id_definition == id && !node.startPoint):
			print(node.startPoint)
			cont+=1;
	var origin = 'startPoint' if cont == 1 else 'endPoint'
	return origin;
	
func reset_nodes(id):
	for node in rest_nodes:
		if(node.id_definition == id && !node.startPoint):
			node.id_definition = 0

func _on_Checkbtn_pressed():
	if(nodes_availables == 0):
		validateAnswers()
		if(correct==6):
			game_state="win"
			$AcceptDialog.dialog_text = "Cool!\nTienes todas las respuestas correctas\nGlóbulos rojos: %0d" % Global.coins
		else:		
			game_state = "lose"
			if Global.coins - 1 > 0:
				Global.coins = Global.coins - 1
				$AcceptDialog.dialog_text = "Oh no!\nTe has equivocado en"+String(incorrect)+"\nHas perdido un glóbulo rojo\nTe quedan: "+str(Global.coins)+"\nVuelve a intentar!"
			else:
				if Global.coins>0: 
					Global.coins = Global.coins - 1		
				$AcceptDialog.dialog_text = "Oh, no!\nTe has quedado sin glóbulos rojos, recolecta más para volver a intentar"
	else:
		$AcceptDialog.dialog_text = "No has terminado el juego todavía"
		$AcceptDialog.popup()
		game_state="not_finished"
	$AcceptDialog.popup()
		


func _on_AcceptDialog_confirmed():
	game_finished()


func game_finished():
	if(game_state=="win"):
		print("wiii")
		Global.scan = false
		Global.lost_challenge = false
		get_tree().change_scene("res://src/scenes/Game_over/game_over.tscn")
		pass
	elif (game_state=="lose"):
		Global.scan = false
		Global.lost_challenge = true
		if (Global.coins >0):
			get_tree().reload_current_scene()
		elif Global.coins == 0:
			print("oops 0 monedas")
			Global.reset_player = true
			get_tree().change_scene("res://src/scenes/immune_system/base_game/stage_3.tscn")
		print(Global.coins);
	else:
		$AcceptDialog.hide()
	
func set_nodes_id_in_rest():
	for node in rest_nodes:
		startpoint_ids.append(node.id_definition)
	
	
