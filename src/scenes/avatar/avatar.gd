extends Node2D


var avatars = {
	"avatar1" : "res://assets/UI/astronauts/avatar1.svg",
	"avatar2" :  "res://assets/UI/astronauts/avatar2.svg",
	"avatar3": "res://assets/UI/astronauts/avatar3.svg",
}


var current_avatar_index;
var avatar;

# Called when the node enters the scene tree for the first time.
func _ready():
	current_avatar_index = 1;
	fetchPlayerStats()
	$astronauta/name.text = PlayerInfo.user_name
	PlayerInfo.logged = true
	
	
	
func change_img_avatar(file):
	var node = $avatar/astronauta

	node.texture = load(file)
	

func _on_buttonRight_button_up():
	current_avatar_index +=1;
	if (current_avatar_index>3):
		current_avatar_index = 1;
	var name="avatar"+String(current_avatar_index)
	avatar = name
	change_img_avatar(avatars[name])


func _on_buttonLeft_button_up():
	current_avatar_index -=1;
	if (current_avatar_index<1):
		current_avatar_index = 3;
	change_img_avatar(avatars["avatar"+String(current_avatar_index)])


func _on_sala_pressed():
	if Global.level == 1:
		get_tree().change_scene("res://src/scenes/immune_system/base_game/stage_1.tscn")
	elif Global.level == 2:
		get_tree().change_scene("res://src/scenes/immune_system/base_game/stage_2.tscn")
	elif Global.level == 3:
		get_tree().change_scene("res://src/scenes/immune_system/base_game/stage_3.tscn")
	 # Replace with function body.

func fetchPlayerStats():
	var email_player = $"/root/PlayerInfo".email.replace("@", "%40");
	$HTTPRequest.request("https://spacetravelers.herokuapp.com/player/statistics?email="+email_player)
	
	pass
	

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
			if(response_code==200):
				print(body.get_string_from_utf8())
				var json = JSON.parse(body.get_string_from_utf8())
				var data = json.result
				_change_stats(data)
				print(data)
	else:
		print("erro prueba")
				
func _change_stats(data):
	$health.value = data.avatar_health
	$food.value = data.avatar_nutrition
	$weight.value = data.avatar_physical_condition
	$happy.value = data.avatar_happiness


func _on_exit_pressed():
	PlayerInfo.logged = false
	PlayerInfo.logout = true
	PlayerInfo.user_name=""
	PlayerInfo.email = ""
	var scene_quit =load("res://src/scenes/quit_message.tscn")
	var scene=scene_quit.instance()
	call_deferred("add_child", scene)
	
