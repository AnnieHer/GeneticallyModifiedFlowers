extends Node2D

@onready var camera_2d: Camera2D = %Camera2D

func _process(_delta: float) -> void:
	if (camera_2d.global_position - global_position).length() < 250.0:
		DialogueConditions.set_condition("Mirror_centered", true)
		DialogueConditions.set_condition("Mirror_not_centered", false)
	else:
		DialogueConditions.set_condition("Mirror_centered", false)
		DialogueConditions.set_condition("Mirror_not_centered", true)
