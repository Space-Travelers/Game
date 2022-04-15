extends Node2D
var coins = 0
func _ready():
	pass


func _on_bloodcell_coin_collected():
	coins = coins +1
	Global.coins +=1 


