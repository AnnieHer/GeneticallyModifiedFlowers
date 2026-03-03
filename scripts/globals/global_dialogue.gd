extends Node2D


var area_2d: Area2D

signal dialogue_read(selected: DialogueComponent)
var selected_node: DialogueComponent
var reading_text: Label
var _reading_time_buffer: float = 2.0
var _reading_speed_per_minute: float = 60.0
var _reading_time: float
var reading: bool = false

func _ready() -> void:
	area_2d = Area2D.new()
	add_child(area_2d)
	area_2d.set_collision_layer_value(1, false)
	area_2d.set_collision_mask_value(1, false)
	area_2d.set_collision_mask_value(3, true)
	var collider = CollisionShape2D.new()
	area_2d.add_child(collider)
	var shape = CircleShape2D.new()
	shape.radius = 1.0
	collider.shape = shape
	reading_text = Label.new()
	area_2d.add_child(reading_text)
	reading_text.text = ""
	reading_text.z_index = 10
	reading_text.position = Vector2(15, 15)


func _display_text(text: String):
	reading_text.text = text
	reading_text.visible_characters = 0
	_reading_time = 0
	
	while reading_text.visible_characters < reading_text.get_total_character_count():
		_reading_time += get_process_delta_time()
		reading_text.visible_characters = _reading_speed_per_minute * _reading_time as int
		await get_tree().process_frame
	var _full_read_time = _reading_time + _reading_time * _reading_time_buffer
	while _reading_time < _full_read_time + 2.0:
		_reading_time += get_process_delta_time()
		await get_tree().process_frame
	reading_text.text = ""
	reading = false

func sort_by_z(a: DialogueComponent, b: DialogueComponent):
	if a.z_index > b.z_index:
		return true
	return false


func _physics_process(_delta: float) -> void:
	area_2d.position = get_global_mouse_position()
	var arr: Array[DialogueComponent]
	for element in area_2d.get_overlapping_areas():
		arr.append(element as DialogueComponent)
	arr.sort_custom(sort_by_z)
	if Input.is_action_just_pressed("dialogue_try") and not arr.is_empty() and not reading:
		reading = true
		selected_node = arr.get(0)
		dialogue_read.emit(selected_node)
		_display_text(selected_node.read())
	
