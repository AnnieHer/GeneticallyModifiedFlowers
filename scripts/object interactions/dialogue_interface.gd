class_name DialogueComponent
extends Area2D

@export var dialogue_options : Array[DialogueElement]

func _init() -> void:
	set_collision_layer_value(1, false)
	set_collision_layer_value(3, true)
	set_collision_mask_value(1, false)


func add_dialogue(element: DialogueElement):
	dialogue_options.append(element)

func read() -> String:
	for option in dialogue_options:
		if option.is_condition_met():
			return option.read()
	return String("")
