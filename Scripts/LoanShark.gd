extends KinematicBody2D

var player_in_sight
var player_in_range

var max_hp = 100
var current_hp
var dead = false 
var speed = 55
var player_position
var target_position
var state = "Rest"

var player_seen


onready var player = get_parent().get_node("player")
onready var rayCast = $RayCast2D



func _ready():
	get_node("AnimationPlayer").play("IdleDown")
	





func _process(delta):
	if dead == true:
		pass
	else:
		match state:
			"Rest":
				print("zzzzz")
			"Follow":
				print("GIVEMEMONEY")
			"Search":
				print("whereareyou")





func SightCheck():
	if false:
		if player_in_range == true:
			var space_state = get_world_2d().direct_space_state 
			var sight_check = space_state.intersect_ray(position, player_position, [self],collision_mask)
			
			if sight_check:
				if sight_check.check.collider.name == "player":
					player_in_sight = true   
					state = "Follow"
				else:
					player_in_sight = false
					state = "Rest"
	
	





func _physics_process(delta):
	player_position = player.position
	target_position = (player_position - position).normalized()
	
	var is_in_range = false
	var is_colliding_with_player = false
	
	if (global_position - player.global_position).length() < 50.0:
		is_in_range = true
		
		move_and_slide(target_position * speed)
		look_at(player_position)
		
		## Raycast toward player to find
		#rayCast.cast_to = global_position - player.global_position
		
		if rayCast.is_colliding():
			if rayCast.get_collider().name == "player":
				is_colliding_with_player = true
	
	## Update state
	if is_in_range == true:
		var is_in_sight = is_colliding_with_player
		
		if rayCast.is_colliding():
			if is_in_sight == true:
				player_in_sight = true  
				player_seen = true
				state = "Follow"
	
	## Set to rest
	if is_in_range == false or is_colliding_with_player == false:
		player_in_sight = false
		if player_seen == true:
			state = "Search" 
		else:
			state = "Rest"
	
	

			
		


func _on_Sight_body_entered(body):
	if body == player:
		player_in_range = true
		



func _on_Sight_body_exited(body):
	if body == player:
		player_in_range = false

