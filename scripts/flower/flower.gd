class_name FlowerData
extends Resource

##stem variables
var starting_angle: float
var angle_change: float
var base_lenght: float
var lenght_multiplier: float
var lenght_change: float
var segments: int
var width: float 
var width_multiplier: float
var width_change: float
var stem_color : Color
##core variables
var radius: float
var sides: int
var core_color : Color
##petals variables
var petal_style: EnumGlobal.PETAL_TYPE
var layers_of_petals: int
var amount_of_petals: int
var angle_of_petals: float
var angle_per_layer: float
var lenght_of_petals: float
var width_of_petals: float #in degrees
var petal_color : Color
var petal_color_change : Color
##for combination purposes only
var mutation_score: float


func _init(
	p_starting_angle: float = 0,
	p_angle_change: float = 0,
	p_base_lenght: float = 0,
	p_lenght_multiplier: float = 0,
	p_lenght_change: float = 0,
	p_segments: int = 0,
	p_width: float = 0,
	p_width_multiplier: float = 0,
	p_width_change: float = 0,
	p_stem_color: Color = Color.BLACK,
	p_radius: float = 0,
	p_sides: int = 0,
	p_core_color: Color = Color.BLACK,
	p_petal_style: EnumGlobal.PETAL_TYPE = EnumGlobal.PETAL_TYPE.ONE_SEGMENT,
	p_layers_of_petals: int = 0,
	p_amount_of_petals: int = 0,
	p_angle_of_petals: float = 0,
	p_angle_per_layer: float = 0,
	p_lenght_of_petals: float = 0,
	p_width_of_petals: float = 0,
	p_petal_color: Color = Color.BLACK,
	p_petal_color_change: Color = Color.BLACK,
	p_mutation_score: float = 0.0
	):
		starting_angle = p_starting_angle
		angle_change = p_angle_change
		base_lenght = p_base_lenght
		lenght_multiplier = p_lenght_multiplier
		lenght_change = p_lenght_change
		segments = p_segments
		width = p_width
		width_multiplier = p_width_multiplier
		width_change = p_width_change
		stem_color = p_stem_color
		radius = p_radius
		sides = p_sides
		core_color = p_core_color
		petal_style = p_petal_style
		layers_of_petals = p_layers_of_petals
		amount_of_petals = p_amount_of_petals
		angle_of_petals = p_angle_of_petals
		angle_per_layer = p_angle_per_layer
		lenght_of_petals = p_lenght_of_petals
		width_of_petals = p_width_of_petals
		petal_color = p_petal_color
		petal_color_change = p_petal_color_change
		mutation_score = p_mutation_score


static func randomize() -> FlowerData:
	var flower := FlowerData.new()
	flower.starting_angle = randf_range(60.0, 120.0)
	flower.angle_change = randf_range(-15.0, 15.0)
	flower.base_lenght = randf_range(50.0, 80.0)
	flower.lenght_multiplier = randf_range(0.8, 0.95)
	flower.lenght_change = 0.0
	flower.segments = randi_range(4, 8)
	flower.width = randf_range(15.0, 30.0)
	flower.width_multiplier = randf_range(0.8, 0.95)
	flower.width_change = 0
	flower.stem_color = Color(randf(), randf(), randf(), 1.0)
	flower.radius = randf_range(10.0, 25.0)
	flower.sides = randi_range(6, 16)
	flower.core_color = Color(randf(), randf(), randf(), 1.0)
	flower.petal_style = randi_range(0, 2) as EnumGlobal.PETAL_TYPE
	
	flower.layers_of_petals = randi_range(1, 4)
	flower.amount_of_petals = randi_range(1, 30)
	flower.angle_of_petals = randf_range(0.0, 360.0)
	flower.angle_per_layer = randf_range(0.0, 360.0)
	flower.lenght_of_petals = randf_range(70.0, 150.0)
	flower.width_of_petals = randf_range(5.0, 12.0)
	flower.petal_color = Color(randf(), randf(), randf(), 1.0)
	flower.petal_color_change = Color(randf(), randf(), randf(), 1.0)
	flower.mutation_score = randf_range(-0.5, 0.5)
	return flower
