extends Node2D



func _ready() -> void:
	y_sort_enabled = true
	z_index = 3
	
	
func get_flower_sort() -> Node2D:
	return self
