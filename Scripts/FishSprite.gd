extends Sprite

var fish_type : int

func _ready():
	fish_type = randi() % 4
	set_fish_appearance()

func set_fish_appearance():
	match fish_type:
		0:
			texture = preload("res://Art/Fish-1.png.png")
		1:
			texture = preload("res://Art/Fish II-1.png (1).png")
		2:
			texture = preload("res://Art/Fish III-1.png.png")
		3:
			texture = preload("res://Art/Fish IV-1.png.png")

func catch():
	queue_free()  # Remove the fish from the scene
	# Add any other logic for what happens when the fish is caught
