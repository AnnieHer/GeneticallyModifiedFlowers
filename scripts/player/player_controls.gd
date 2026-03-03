extends CharacterBody2D
const SPEED: float = 200
var move_dir: float
@export_range(10, 1000, 10) var max_speed: float = 200
@export_range(0, 1, 0.01) var damping: float = 0.7
func _physics_process(delta: float) -> void:
	move_dir = Input.get_axis("move_left", "move_right")
	velocity.x += move_dir * SPEED 
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	velocity.x *= damping
	move_and_slide()
