extends Node2D
var coins = 0
export var display_time: float = 10
export var text_popup = "hola"
func _ready():
	pass


func _on_bloodcell_coin_collected():
	coins = coins +1
	Global.coins +=1 


