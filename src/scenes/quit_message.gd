extends CanvasLayer

func _ready():
	get_tree().paused = true
	if PlayerInfo.logged:
		$Exit_no_logged.hide()
		$logged_out.hide()
		$logged.show()
	elif PlayerInfo.logout:
		$Exit_no_logged.hide()
		$logged.hide()
		$logged_out.show()
		PlayerInfo.logout = false
				
	else: 
		$logged.hide()
		$logged_out.hide()
		$Exit_no_logged.show()
	
	
	pass # Replace with function body.



func _on_Exit_pressed():
	get_tree().quit()


func _on_Back_pressed():
	get_tree().paused = false
	get_parent().remove_child(self)
	
	pass # Replace with function body.


func _on_logout_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://src/scenes/login/login.tscn")
	pass # Replace with function body.
