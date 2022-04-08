extends Node2D
var coins = 0


func _on_bloodcell_coin_collected():
	coins = coins +1
	var coin_score = "Coins: " + String(coins)
	Global.coins +=1 
