extends Node2D

@export var button: Button
@export var slot1: ObjectSlot
@export var slot2: ObjectSlot
var flower1: FlowerData
var flower2: FlowerData

func _ready() -> void:
	if button:
		button.pressed.connect(_try_combine)

func _try_combine():
	var object1: DragComponent = slot1.get_selected()
	if object1:
		if object1.get_parent() is Flower:
			flower1 = object1.get_parent().get_flower_data()
		else:
			flower1 = FlowerData.randomize()
	else:
		return
	
	var object2: DragComponent = slot2.get_selected()
	if object2:
		if object2.get_parent() is Flower:
			flower2 = object2.get_parent().get_flower_data()
		else:
			flower2 = FlowerData.randomize()
	else:
		return
	
	var flower: Flower = Flower.new(FlowerCombiner.Combine_Mix(flower1, flower2))
	get_parent().add_child(flower)
	flower.position = position
