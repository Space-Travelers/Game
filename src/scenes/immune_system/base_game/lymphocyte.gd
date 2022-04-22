extends KinematicBody2D

const SPEED = 80
const GRAVITY = 10
const JUMP_POWER = -450
const FLOOR = Vector2(0,-1)

var velocity = Vector2()
var on_ground = false
var jump_count = 0
export var extra_jump = 1


onready var animation = $AnimatedSprite;

func _ready():
	if Global.lost_challenge and Global.coins > 0:
			set_global_position(Vector2(Global.playerx,Global.playery))
			animation.play("Loser")
	elif Global.lost_challenge and Global.coins == 0:
			set_global_position(Vector2(Global.posxplayer,Global.posyplayer))
			animation.play("Loser")
			
	
func _physics_process(delta):
	if Input.is_action_pressed("ui_right") and not Global.scan:
		animation.play("run_right")
		velocity.x = SPEED
	elif Global.scan:
		animation.play("scan")
	elif Input.is_action_pressed("ui_left") and not Global.scan:
		animation.play("run_left")
		velocity.x = -SPEED
		
	else:
		velocity.x = 0
	if Input.is_action_pressed("ui_up") && jump_count < extra_jump:
		jump_count+=1
		velocity.y = JUMP_POWER	
		on_ground = false
		

		
	velocity.y += GRAVITY
	
	if is_on_floor():
		on_ground = true
		jump_count = 0

	velocity = move_and_slide(velocity, FLOOR)

func _on_Virus_area_entered(area):

	print("virus area")
	print("vamo a escanearrrrr")
	Global.visible_button = true
	Global.playerx = global_position.x
	Global.playery = global_position.y
	Global.scan = true 	

	pass # Replace with function body. 
	
func _on_Tutorial_area_entered(area):
	print("hey")
	pass
