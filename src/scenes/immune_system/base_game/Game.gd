extends Node2D
var coins = 0
func _ready():
	Global.stage=2
	print("I'M READY")


func _on_bloodcell_coin_collected():
	coins = coins +1
	var coin_score = "Health: " + String(coins)
	Global.coins +=1 


