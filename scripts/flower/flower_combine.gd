class_name FlowerCombiner
extends Node


static func Combine_Mix(flower1: FlowerData, flower2: FlowerData) -> FlowerData:
	var flower := FlowerData.new()
	flower.starting_angle = (flower1.starting_angle + flower2.starting_angle) / 2 + randf_range(-1.0, 1.0) * (flower1.mutation_score + flower2.mutation_score)
	flower.angle_change = (flower1.angle_change + flower2.angle_change) / 2 + randf_range(-1.0, 1.0) * (flower1.mutation_score + flower2.mutation_score)
	
	flower.base_lenght = (flower1.base_lenght + flower2.base_lenght) / 2 + randf_range(0, 1.0) * (flower1.mutation_score + flower2.mutation_score)
	flower.lenght_multiplier = (flower1.lenght_multiplier + flower2.lenght_multiplier) / 2
	flower.lenght_change = (flower1.lenght_change + flower2.lenght_change) / 2
	flower.segments = randi_range(flower1.segments, flower2.segments) + int(randf_range(0, flower1.mutation_score + flower2.mutation_score))
	
	flower.width = (flower1.width + flower2.width) / 2
	flower.width_multiplier = (flower1.width_multiplier + flower2.width_multiplier) / 2
	flower.width_change = (flower1.width_change + flower2.width_change) / 2
	flower.stem_color = (flower1.stem_color + flower2.stem_color) / 2
	
	flower.radius = (flower1.radius + flower2.radius) / 2 + randf_range(0, 1.0) * (flower1.mutation_score + flower2.mutation_score)
	flower.sides = randi_range(flower1.sides, flower2.sides)
	flower.core_color = (flower1.core_color + flower2.core_color) / 2
	
	flower.petal_style = flower1.petal_style if randi_range(0, 1) == 0 else flower2.petal_style
	flower.layers_of_petals = randi_range(flower1.layers_of_petals, flower2.layers_of_petals)
	flower.amount_of_petals = clampi(int(randf_range(flower1.amount_of_petals, flower2.amount_of_petals)) + int(randf_range(-1, flower1.mutation_score + flower2.mutation_score)), 1, 30)
	flower.angle_of_petals = (flower1.angle_of_petals + flower2.angle_of_petals) / 2 + randf_range(-1.0, 1.0) * (flower1.mutation_score + flower2.mutation_score)
	flower.angle_per_layer = (flower1.angle_per_layer + flower2.angle_per_layer) / 2 + randf_range(-1.0, 1.0) * (flower1.mutation_score + flower2.mutation_score)
	flower.lenght_of_petals = (flower1.lenght_of_petals + flower2.lenght_of_petals) / 2 + randf_range(0, 1.0) * (flower1.mutation_score + flower2.mutation_score)
	flower.width_of_petals = (flower1.width_of_petals + flower2.width_of_petals) / 2
	flower.petal_color = (flower1.petal_color + flower2.petal_color) / 2
	flower.petal_color_change = (flower1.petal_color_change + flower2.petal_color_change) / 2
	flower.mutation_score = clampf(flower1.mutation_score + flower2.mutation_score, -0.5, 5.0)
	return flower
