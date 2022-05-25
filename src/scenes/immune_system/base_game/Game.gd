extends Node2D
export var nextScene: String = ""
export var currentLevel: int = 0

func _ready():
	Global.level = currentLevel
	pass
	
	
func _on_bloodcell_coin_collected():
	Global.coins +=1 


func _on_TextureButton_pressed():
	$Panel.hide() # Replace with function body.




func _on_restart_pressed():
	print("reset")
	$Panel.hide()
	$restart.hide()
	$game_items/Lymphocyte.reset_lymp() # Replace with function body.


func _on_Virus_area_entered(area):
	print("virus area")
	Global.reset_player = false
	Global.scan = false 	
	Global.scan_area = false
	
	if Global.coins>0:
		$Panel.hide()
		$restart.hide()
		get_tree().change_scene(nextScene)
	else:
		$Panel/Label.text = "Oh no, no tienes glóbulos rojos para desafiar al virus! :("
		$Panel.show()
		$restart.show()
		
		
	pass # Replace with function body.


func _on_fallen_zone_area_entered(area):
	$game_items/Lymphocyte.reset_lymp()
	pass # Replace with function body.


func _on_Virus_area_exited(area):
	$Panel.hide()
	$restart.hide()
	
	pass # Replace with function body.
