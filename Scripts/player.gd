extends KinematicBody2D

var speed = 70
var motion = Vector2.ZERO

# warning-ignore:unused_argument
func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.play("rightwalk")
		motion.x = speed 
		motion.y = 0
	elif Input.is_action_pressed("ui_left"):
		$AnimatedSprite.play("leftwalk")
		motion.x = -speed
		motion.y = 0
	elif Input.is_action_pressed("ui_up"):
		$AnimatedSprite.play("upwalk")
		motion.y = -speed
		motion.x = 0
	elif Input.is_action_pressed("ui_down"):
		$AnimatedSprite.play("downwalk")
		motion.y = speed
		motion.x = 0
	else:
		$AnimatedSprite.play("idle")
		motion.x = 0
		motion.y = 0
		
# warning-ignore:return_value_discarded
	move_and_slide(motion)



