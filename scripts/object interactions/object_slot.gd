class_name ObjectSlot
extends Area2D


signal object_entered(object: DragComponent)
signal object_exited(object: DragComponent)

var selected_object: DragComponent

@export var dispose_speed: float = 3
@export var dispose_position: Vector2 = Vector2(0.0, 150.0)
@export var collision_size: Vector2 = Vector2(50.0, 50.0)

func get_selected() -> DragComponent:
	return selected_object

func _ready() -> void:
	var collider = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.size = collision_size
	collider.shape = shape
	add_child(collider)
	
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, true)
	area_entered.connect(_object_entered)
	area_exited.connect(_object_exited)


func _move_object(object: DragComponent, target_pos: Vector2):
	while true:
		object.set_obj_position(object.get_obj_position().lerp(target_pos, 1 - exp(-dispose_speed * get_process_delta_time())))  
		await get_tree().process_frame
		
		if !object:
			break
		if (object.get_obj_position() - target_pos).length_squared() < 1.0 or object.is_selected:
			break


func _object_exited(area: Area2D):
	if area == selected_object:
		object_exited.emit(selected_object)
		selected_object = null


func _object_entered(area: Area2D):
	if area is DragComponent:
		Input.action_release("select_or_drag")
		await area.unselected
		if selected_object: _move_object(selected_object, global_position + dispose_position)
		selected_object = area
		object_entered.emit(selected_object)
		_move_object(selected_object, global_position)
