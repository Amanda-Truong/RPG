extends KinematicBody2D

const MOTION_SPEED = 160 # Pixels/second

func _physics_process(delta):
	var motion = Vector2()
	var a = $AnimatedSprite
	if Input.is_action_pressed("ui_up"):
		motion += Vector2(0, -1)
		print(a.animation, "AAAA")
		a.animation = "back"
	if Input.is_action_pressed("ui_down"):
		motion += Vector2(0, 1)
		a.animation = "front"
	if Input.is_action_pressed("ui_left"):
		motion += Vector2(-1, 0)
		a.animation = "left"
	if Input.is_action_pressed("ui_right"):
		motion += Vector2(1, 0)
		a.animation = "right"
	
	motion = motion.normalized() * MOTION_SPEED
	move_and_slide(motion)
	
	
func get_name(): 
		return "player" 
