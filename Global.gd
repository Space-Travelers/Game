extends Node
var lost_challenge = false
var first_play= true
var coin_collected = false
var coins = 0
var actual_id_definition = -1
var stage = 1
var visible_button = false
var tutorial = true
var scan = false
var scan_area = false
var rest = true
var dialog_zone = "tutorial"
var reset_player = false
var level = 1

var user_name = "aaa";

var playerx=49
var playery=353

var posxplayer=49
var posyplayer=353


func _notification(exit):
	print("hola xd")
	var scene_quit =load("res://src/scenes/quit_message.tscn")
	var scene=scene_quit.instance()
	print_tree()
	if exit == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		call_deferred("add_child", scene)
		get_tree().set_auto_accept_quit(false)
		#get_tree().quit() # default behavior
