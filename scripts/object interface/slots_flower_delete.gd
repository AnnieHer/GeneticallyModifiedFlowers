extends Node2D


@export var button: Button
@export var slot1: ObjectSlot

func _ready() -> void:
	if button:
		button.pressed.connect(_remove_flower)


func _remove_flower() -> void:
	if slot1.get_selected():
		slot1.get_selected().parent_node.queue_free()
