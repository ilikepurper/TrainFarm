extends Area2D

func _ready():
	var fish_instance = preload("res://Tscn/Fish.tscn").instance()
	add_child(fish_instance)
	fish_instance.position = Vector2(100,100)
 
var fishing_time_min = 5  # Minimum time in seconds
var fishing_time_max = 10  # Maximum time in seconds

func _on_player_entered_fishing_area():
	start_fishing()


func start_fishing():
	var fishing_time = rand_range(fishing_time_min, fishing_time_max)
	var fish_instance = preload("res://Tscn/Fish.tscn").instance()
	add_child(fish_instance)
	fish_instance.position = Vector2(100, 100)  # Set the position of the fish
	yield(get_tree().create_timer(fishing_time), "timeout")  # Wait for the fishing time to elapse
	fish_instance.queue_free()  # Remove the fish from the scene
