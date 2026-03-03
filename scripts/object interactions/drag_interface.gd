class_name DragComponent
extends Area2D

@export var parent_node: Node2D
var default_rotation: float = 0
var is_selected: bool = false
@export var amp:= 0.02
@export var freq:= 0.01
signal selected
signal unselected

func _init(node: Node2D) -> void:
	parent_node = node
	
	set_collision_layer_value(1, false)
	set_collision_layer_value(2, true)
	set_collision_mask_value(1, false)
	default_rotation = parent_node.rotation


func _process(_delta: float) -> void:
	if not is_selected:
		return
	parent_node.rotation = default_rotation + sin(Time.get_ticks_msec() * freq) * amp


func select():
	is_selected = true
	selected.emit()


func unselect():
	is_selected = false
	parent_node.rotation = default_rotation
	unselected.emit()


func get_obj_position() -> Vector2:
	return parent_node.position
	
func set_obj_position(pos: Vector2):
	parent_node.position = pos
