extends Node2D
var coins = 0
func _ready():
	pass
	
	
func _on_bloodcell_coin_collected():
	coins = coins +1
	Global.coins +=1 




func _on_lost_challenge_area2_area_entered(area):
	if Global.coins == 0:
		$Panel/Label.text = "Hey! No tienes suficientes\nmonedas"
		$Panel.show() 	


func _on_TextureButton_pressed():
	$Panel.hide() # Replace with function body.



func _on_help_pressed():
	$"Help-panel/Ayuda".show() # Replace with function body.


func _on_close_pressed():
	$"Help-panel/Ayuda".hide()
