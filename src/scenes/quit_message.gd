extends CanvasLayer

func _ready():
	print("aaaaa")
	if PlayerInfo.logged:
		$Exit_no_logged.hide()
		$logged.show()		
	else: 
		$Exit_no_logged.show()
		
	pass # Replace with function body.



func _on_Exit_pressed():
	get_tree().quit()


func _on_Back_pressed():
	get_parent().remove_child(self)
	
	pass # Replace with function body.
