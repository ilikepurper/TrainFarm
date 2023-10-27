extends KinematicBody2D

var speed = 70
var motion = Vector2.ZERO
var prev_key = ""
var current_hp 
var damage = 10
var hp = 100




## References
var fish_sprite_images = [
	preload("res://Art/Fish1.png"),
	preload("res://Art/Fish2.png"),
	preload("res://Art/Fish3.png"),
	preload("res://Art/Fish4.png")
]

onready var animationPlayer = $AnimationPlayer


# warning-ignore:unused_argument
func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		animationPlayer.play("RunRight")
		motion.x = speed 
		motion.y = 0
		prev_key = "ui_right"
			
	elif Input.is_action_pressed("ui_left"):
		animationPlayer.play("LeftWalk")
		motion.x = -speed
		motion.y = 0
		prev_key = "ui_left"
	elif Input.is_action_pressed("ui_up"):
		animationPlayer.play("UpWalk")
		motion.y = -speed
		motion.x = 0
		prev_key = "ui_up"
	elif Input.is_action_pressed("ui_down"):
		animationPlayer.play("DownWalk")
		motion.y = speed
		motion.x = 0
		prev_key = "ui_down"
		
	else:
		if prev_key == "ui_right":
			animationPlayer.play("IdleRight") 
		if prev_key == "ui_left":
			animationPlayer.play("IdleLeft")
		if prev_key == "ui_down":
			animationPlayer.play("IdleDown")
		if prev_key == "ui_up":
			animationPlayer.play("IdleUp")

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
var mouse_pos = Vector2.ZERO
	
func _ready():
	fishing_area = get_parent().get_node("FishingArea")
	collision_shape_2D = $CollisionShape2D
	last_start_time = (OS.get_ticks_msec())
	#connect("player_entered", fishing_area, "_on_FishingArea_body_shape_entered")
	current_hp = hp




func _process(delta):
	var time_in_seconds = ( (OS.get_ticks_msec() - last_start_time) / 1000.0)
	
	if just_entered == true and (time_in_seconds > rand_range(4.0, 7.0)):
		last_start_time = (OS.get_ticks_msec() )
		speed = 70
		FishSprite.visible = false
		
	elif just_entered == true and (time_in_seconds <= rand_range(3.0, 6.0)):
		FishSprite.global_position = lerp(FishSprite.global_position, global_position - Vector2(0, 20), 0.1)
		
	if has_not_exited == true:
		FishSprite.visible = true
	else:
		FishSprite.visible = false
		

		


func _on_FishingArea_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "player" and has_not_exited == false:
		FishSprite.global_position = FishSprite.global_position - (global_position - fishing_area.global_position).normalized() * 20
		has_not_exited = true
		just_entered = true
		speed = 0
		#FishSprite.visible = true
		FishSprite.texture =  fish_sprite_images[randi() % fish_sprite_images.size()]
	
		# Fish sprite comes out of water and kills you
		is_fish_animating = true
		print(prev_key)
		
		if (prev_key == "ui_up"):
			animationPlayer.stop()
			animationPlayer.play("FishUp")
		if(prev_key == "ui_left"):
			animationPlayer.stop()
			animationPlayer.play("IdleLeft")
		
		

func _on_FishingArea_body_exited(body):
	if body.name == "player":
		if has_not_exited == true:
			has_not_exited = false
			just_entered = false
			speed = 70

func OnHit(damage):
	current_hp -= damage
	print(current_hp)
	
