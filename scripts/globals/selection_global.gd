extends Node2D


var area_2d: Area2D

signal node_selected(selected: DragComponent)
var selected_node: DragComponent

var offset: Vector2 = Vector2()


func _ready() -> void:
	area_2d = Area2D.new()
	add_child(area_2d)
	area_2d.set_collision_layer_value(1, false)
	area_2d.set_collision_mask_value(1, false)
	area_2d.set_collision_mask_value(2, true)
	var collider = CollisionShape2D.new()
	area_2d.add_child(collider)
	var shape = CircleShape2D.new()
	shape.radius = 1.0
	collider.shape = shape

func sort_by_z(a: DragComponent, b: DragComponent):
	if a.get_obj_position().y > b.get_obj_position().y:
		return true
	return false


func _physics_process(_delta: float) -> void:
	area_2d.position = get_global_mouse_position()
	var arr: Array[DragComponent]
	for element in area_2d.get_overlapping_areas():
		arr.append(element as DragComponent)
	arr.sort_custom(sort_by_z)
	if Input.is_action_just_pressed("select_or_drag") and not arr.is_empty():
		selected_node = arr.get(0)
		node_selected.emit(selected_node)
		selected_node.select()
		offset = selected_node.get_obj_position() - get_global_mouse_position()
	if Input.is_action_just_released("select_or_drag") and selected_node:
		selected_node.unselect()
		selected_node = null
	if Input.is_action_pressed("select_or_drag") and selected_node:
		selected_node.set_obj_position(get_global_mouse_position() + offset)
