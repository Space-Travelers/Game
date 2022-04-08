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
	animation.play("run")
	
func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("ui_left"):
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


func _on_Area2D_body_entered(body):
	pass


func _on_Area2D_body_exited(body):
	pass
	
