extends ParallaxBackground

export (float) var scrolling_speed = 100.0;

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(delta):
	scroll_offset.y += scrolling_speed * delta


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
