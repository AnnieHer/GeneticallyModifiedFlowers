extends Sprite2D

@onready var camera_2d: Camera2D = %Camera2D
@export var amount := 1.0
var center_offset := Vector2()

func _ready() -> void:
	center_offset = position
	

func _process(_delta: float) -> void:
	position = camera_2d.position * amount + center_offset
