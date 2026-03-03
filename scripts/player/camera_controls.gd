extends Camera2D


## for zoom stuff
var target_zoom := 1.0
var zoom_step := 0.1
var zoom_smoothing := 2
## for camera movement stuff
var mouse_pos := Vector2()
var offset_pos := Vector2()
var screen_ratio := Vector2()

func _ready() -> void:
	screen_ratio = Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y)
	screen_ratio = screen_ratio.normalized()
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			target_zoom -= zoom_step
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			target_zoom += zoom_step
func _process(delta: float) -> void:
	_update_zoom(delta)
	
	if Input.is_action_just_pressed("camera_drag"):
		offset_pos = get_viewport().get_mouse_position() / zoom.x + position
	if Input.is_action_pressed("camera_drag"):
		mouse_pos = get_viewport().get_mouse_position() / zoom.x
		position = offset_pos - mouse_pos
	position.x = clampf(position.x, -1536.0 * zoom.x * screen_ratio.x, 1536.0 * zoom.x * screen_ratio.x)
	position.y = clampf(position.y, -1024.0 * zoom.y * screen_ratio.y, 1024.0 * zoom.y * screen_ratio.y)

	

func _update_zoom(delta: float):
	target_zoom = clampf(target_zoom, 0.6, 3)
	zoom.x = lerp(zoom.x, target_zoom, 1 - exp(-zoom_smoothing * delta))
	zoom.y = lerp(zoom.y, target_zoom, 1 - exp(-zoom_smoothing * delta))
