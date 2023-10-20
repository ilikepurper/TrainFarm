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

var fishing_area
onready var FishSprite = $FishSprite
var is_fish_animating = false



	# Placeholder for inventory update
	# TODO: Update inventory with caught fish
	
var collision_shape_2D
var just_entered = false
var has_not_exited = false
var last_start_time = 0.0
	
func _ready():
	fishing_area = get_parent().get_node("FishingArea")
	collision_shape_2D = $CollisionShape2D
	last_start_time = (OS.get_ticks_msec())
	#connect("player_entered", fishing_area, "_on_FishingArea_body_shape_entered")

func _process(delta):
	var time_in_seconds = ( (OS.get_ticks_msec() - last_start_time) / 1000.0)
	
	if just_entered == true and (time_in_seconds > rand_range(3.0, 6.0)):
		last_start_time = (OS.get_ticks_msec() )
		speed = 70
		FishSprite.visible = false
		
	elif just_entered == true and (time_in_seconds <= rand_range(3.0, 6.0)):
		FishSprite.global_position = lerp(FishSprite.global_position, global_position + Vector2(0, 20), 0.1)
		

func _on_FishingArea_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "player" and has_not_exited == false:
		has_not_exited = true
		just_entered = true
		speed = 0
		FishSprite.visible = true
		FishSprite.global_position = FishSprite.global_position - (global_position - fishing_area.global_position).normalized() * 20
	
		# Fish sprite comes out of water and kills you
		is_fish_animating = true

func _on_FishingArea_body_exited(body):
	if body.name == "player":
		if has_not_exited == true:
			has_not_exited = false
			just_entered = false
			speed = 70
