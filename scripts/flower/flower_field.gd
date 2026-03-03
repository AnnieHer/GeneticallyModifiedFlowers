extends Node2D


@export var button: Button


func _ready() -> void:
	if button:
		button.pressed.connect(_summon)


func _summon() -> Flower:
	var flower: Flower = Flower.new()
	FlowerSort.get_flower_sort().add_child.call_deferred(flower)
	flower.position = position
	return flower
