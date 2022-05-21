extends Node2D
export var nextScene: String = ""

func _ready():
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
		get_tree().change_scene(nextScene)
	else:
		$Panel/Label.text = "Oh no, no tienes glóbulos rojos para desafiar al virus! :("
		$Panel.show()
		$restart.show()
		
		
	pass # Replace with function body.
