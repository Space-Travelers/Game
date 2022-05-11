extends Node2D


var avatars = {
	"avatar1" : "res://assets/UI/astronauts/avatar1.svg",
	"avatar2" :  "res://assets/UI/astronauts/avatar2.svg",
	"avatar3": "res://assets/UI/astronauts/avatar3.svg",
}

var health1=70
var current_avatar_index;
var avatar;

# Called when the node enters the scene tree for the first time.
func _ready():
	current_avatar_index = 1;
	$health.value=health1
	
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
	get_tree().change_scene("res://src/scenes/immune_system/base_game/stage_1.tscn")
	 # Replace with function body.
