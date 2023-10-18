extends Node2D

const plant = preload("res://Wheat/Wheat.tscn")





func _input(event):
	if event.is_action("Spawn"):
		var plant1 = plant.instance()
		plant1.position = get_global_mouse_position()
		get_node("Wheat").add_child(plant1)
