extends Node2D

enum FishType {
	FISH_TYPE_1,
	FISH_TYPE_2,
	FISH_TYPE_3,
	FISH_TYPE_4,
}

var fish_type : FishType

func _ready():
	fish_type = FishType(randi() % 4)
