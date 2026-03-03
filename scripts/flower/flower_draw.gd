class_name Flower
extends Node2D


@export var flower_data: FlowerData
@export var mesh_instance: MeshInstance2D
@export var drag_component: DragComponent
@export var drag_component_shape: CollisionPolygon2D
@export var dialogue_component: DialogueComponent
@export var dialogue_component_shape: CollisionShape2D



func _init(data: FlowerData = null) -> void:
	_setup(data)
	_render()


func _setup(data: FlowerData = null):
	rotation = deg_to_rad(180.0)
	
	flower_data = FlowerData.randomize() if not data else data
	
	if not mesh_instance:
		mesh_instance = MeshInstance2D.new()
		add_child(mesh_instance)
	if not drag_component:
		drag_component = DragComponent.new(self)
		add_child(drag_component)
	if not drag_component_shape:
		drag_component_shape = CollisionPolygon2D.new()
		drag_component.add_child(drag_component_shape)
	if not dialogue_component:
		dialogue_component = DialogueComponent.new()
		add_child(dialogue_component)
		dialogue_component.add_dialogue(load("res://resources/dialogue elements/flower_default.tres"))
	if not dialogue_component_shape:
		dialogue_component_shape = CollisionShape2D.new()
		dialogue_component.add_child(dialogue_component_shape)
		


func get_flower_data() -> FlowerData:
	return flower_data

func _render():
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	var core_spot =	_render_the_stem(st)
	_render_the_petals(st, core_spot)
	_render_the_core(st, core_spot)
	mesh_instance.mesh = st.commit()
	
	## regenerating stem's points for collision
	drag_component_shape.polygon = _stem_collision()
	
	var shape := ConvexPolygonShape2D.new()
	var cloud := PackedVector2Array()
	for point in mesh_instance.mesh.create_convex_shape().points:
		cloud.append(Vector2(point.x, point.y))
	shape.set_point_cloud(cloud)
	dialogue_component_shape.shape = shape
	st.index()

func _stem_collision() -> PackedVector2Array:
	var cloud: PackedVector3Array = PackedVector3Array()
	var loops = 0
	var floating_position = Vector3.UP
	cloud.insert(0, floating_position + floating_position.rotated(Vector3.FORWARD, deg_to_rad(90 - flower_data.angle_change)).normalized() * (((flower_data.width + flower_data.width_change * loops) * pow(flower_data.width_multiplier, loops))/2))
	cloud.append(floating_position + floating_position.rotated(Vector3.FORWARD, deg_to_rad(-90 - flower_data.angle_change)).normalized() * (((flower_data.width + flower_data.width_change * loops) * pow(flower_data.width_multiplier, loops))/2))
	while loops < flower_data.segments:
		var new_floating_position = floating_position + Vector3(cos(deg_to_rad(flower_data.starting_angle + flower_data.angle_change * loops)), \
		sin(deg_to_rad(flower_data.starting_angle + flower_data.angle_change * loops)), 0) * ((flower_data.base_lenght + flower_data.lenght_change * loops) * pow(flower_data.lenght_multiplier, loops))
		cloud.append(new_floating_position + new_floating_position.rotated(Vector3.FORWARD, deg_to_rad(-90 - flower_data.angle_change)).normalized() * (((flower_data.width + flower_data.width_change * loops) * pow(flower_data.width_multiplier, loops + 1))/2))
		cloud.insert(0, new_floating_position + new_floating_position.rotated(Vector3.FORWARD, deg_to_rad(90 - flower_data.angle_change)).normalized() * (((flower_data.width + flower_data.width_change * loops) * pow(flower_data.width_multiplier, loops + 1))/2))
		floating_position = new_floating_position
		loops += 1
	
	var cloud2: PackedVector2Array = PackedVector2Array()
	for point in cloud:
		cloud2.insert(0, Vector2(point.x, point.y))
	return cloud2


func _render_the_stem(st: SurfaceTool) -> Vector3:
	var loops = 0
	var floating_position = Vector3.UP
	st.set_color(flower_data.stem_color)
	while loops < flower_data.segments:
		var new_floating_position = floating_position + Vector3(cos(deg_to_rad(flower_data.starting_angle + flower_data.angle_change * loops)), \
		sin(deg_to_rad(flower_data.starting_angle + flower_data.angle_change * loops)), 0) * ((flower_data.base_lenght + flower_data.lenght_change * loops) * pow(flower_data.lenght_multiplier, loops))
		st.add_vertex(floating_position + floating_position.rotated(Vector3.FORWARD, deg_to_rad(-90 - flower_data.angle_change)).normalized() * (((flower_data.width + flower_data.width_change * loops) * pow(flower_data.width_multiplier, loops))/2))
		st.add_vertex(floating_position + floating_position.rotated(Vector3.FORWARD, deg_to_rad(90 - flower_data.angle_change)).normalized() * (((flower_data.width + flower_data.width_change * loops) * pow(flower_data.width_multiplier, loops))/2))
		st.add_vertex(new_floating_position + new_floating_position.rotated(Vector3.FORWARD, deg_to_rad(-90 - flower_data.angle_change)).normalized() * (((flower_data.width + flower_data.width_change * loops) * pow(flower_data.width_multiplier, loops + 1))/2))
		st.add_vertex(new_floating_position + new_floating_position.rotated(Vector3.FORWARD, deg_to_rad(-90 - flower_data.angle_change)).normalized() * (((flower_data.width + flower_data.width_change * loops) * pow(flower_data.width_multiplier, loops + 1))/2))
		st.add_vertex(new_floating_position + new_floating_position.rotated(Vector3.FORWARD, deg_to_rad(90 - flower_data.angle_change)).normalized() * (((flower_data.width + flower_data.width_change * loops) * pow(flower_data.width_multiplier, loops + 1))/2))
		st.add_vertex(floating_position + floating_position.rotated(Vector3.FORWARD, deg_to_rad(90 - flower_data.angle_change)).normalized() * (((flower_data.width + flower_data.width_change * loops) * pow(flower_data.width_multiplier, loops))/2))
		floating_position = new_floating_position
		loops += 1
	return floating_position


func _render_the_core(st: SurfaceTool, core_pos: Vector3):
	var loops = 0
	st.set_color(flower_data.core_color)
	while loops < flower_data.sides - 1:
		st.add_vertex(core_pos + flower_data.radius * Vector3(cos(deg_to_rad(360.0 / flower_data.sides)), sin(deg_to_rad(360.0 / flower_data.sides)), 0))
		st.add_vertex(core_pos + flower_data.radius * Vector3(cos(deg_to_rad((360.0 / flower_data.sides) * (loops + 1))), sin(deg_to_rad(360.0 / flower_data.sides * (loops + 1))), 0))
		st.add_vertex(core_pos + flower_data.radius * Vector3(cos(deg_to_rad((360.0 / flower_data.sides) * (loops + 2))), sin(deg_to_rad(360.0 / flower_data.sides * (loops + 2))), 0))
		loops += 1


func _render_the_petals(st: SurfaceTool, core_pos: Vector3):
	var loops = 0
	var petal_angle: Vector3
	st.set_color(flower_data.petal_color)
	while loops < flower_data.layers_of_petals:
		petal_angle = core_pos.normalized().rotated(Vector3.FORWARD, deg_to_rad(flower_data.angle_of_petals + flower_data.angle_per_layer * loops))
		var loops1 = 0
		while loops1 < flower_data.amount_of_petals:
			match flower_data.petal_style:
				EnumGlobal.PETAL_TYPE.ONE_SEGMENT:
					st.add_vertex(core_pos)
					st.add_vertex(core_pos + petal_angle.rotated(Vector3.FORWARD, deg_to_rad(flower_data.width_of_petals)) * flower_data.lenght_of_petals)
					st.add_vertex(core_pos + petal_angle.rotated(Vector3.FORWARD, deg_to_rad(-flower_data.width_of_petals)) * flower_data.lenght_of_petals)
					
				EnumGlobal.PETAL_TYPE.TWO_SEGMENT:
					st.add_vertex(core_pos)
					st.add_vertex(core_pos + petal_angle.rotated(Vector3.FORWARD, deg_to_rad(flower_data.width_of_petals)) * flower_data.lenght_of_petals / 2)
					st.add_vertex(core_pos + petal_angle.rotated(Vector3.FORWARD, deg_to_rad(-flower_data.width_of_petals)) * flower_data.lenght_of_petals / 2)
					
					st.add_vertex(core_pos + petal_angle.rotated(Vector3.FORWARD, deg_to_rad(-flower_data.width_of_petals)) * flower_data.lenght_of_petals / 2)
					st.add_vertex(core_pos + petal_angle.rotated(Vector3.FORWARD, deg_to_rad(flower_data.width_of_petals)) * flower_data.lenght_of_petals / 2)
					st.add_vertex(core_pos + petal_angle * flower_data.lenght_of_petals)
					
				EnumGlobal.PETAL_TYPE.THREE_SEGMENT:
					st.add_vertex(core_pos)
					st.add_vertex(core_pos + petal_angle.rotated(Vector3.FORWARD, deg_to_rad(flower_data.width_of_petals)) * flower_data.lenght_of_petals / 3)
					st.add_vertex(core_pos + petal_angle.rotated(Vector3.FORWARD, deg_to_rad(-flower_data.width_of_petals)) * flower_data.lenght_of_petals / 3)
					
					st.add_vertex(core_pos + petal_angle.rotated(Vector3.FORWARD, deg_to_rad(flower_data.width_of_petals)) * flower_data.lenght_of_petals / 3)
					st.add_vertex(core_pos + petal_angle.rotated(Vector3.FORWARD, deg_to_rad(-flower_data.width_of_petals)) * flower_data.lenght_of_petals / 3)
					st.add_vertex(core_pos + petal_angle * flower_data.lenght_of_petals / 3 + petal_angle.rotated(Vector3.FORWARD, deg_to_rad(flower_data.width_of_petals)) * flower_data.lenght_of_petals / 3)
					
					st.add_vertex(core_pos + petal_angle.rotated(Vector3.FORWARD, deg_to_rad(-flower_data.width_of_petals)) * flower_data.lenght_of_petals / 3)
					st.add_vertex(core_pos + petal_angle * flower_data.lenght_of_petals / 3 + petal_angle.rotated(Vector3.FORWARD, deg_to_rad(flower_data.width_of_petals)) * flower_data.lenght_of_petals / 3)
					st.add_vertex(core_pos + petal_angle * flower_data.lenght_of_petals / 3 + petal_angle.rotated(Vector3.FORWARD, deg_to_rad(-flower_data.width_of_petals)) * flower_data.lenght_of_petals / 3)
					
					st.add_vertex(core_pos + petal_angle * flower_data.lenght_of_petals / 3 + petal_angle.rotated(Vector3.FORWARD, deg_to_rad(-flower_data.width_of_petals)) * flower_data.lenght_of_petals / 3)
					st.add_vertex(core_pos + petal_angle * flower_data.lenght_of_petals / 3 + petal_angle.rotated(Vector3.FORWARD, deg_to_rad(flower_data.width_of_petals)) * flower_data.lenght_of_petals / 3)
					st.add_vertex(core_pos + petal_angle * flower_data.lenght_of_petals)
			petal_angle = petal_angle.rotated(Vector3.FORWARD, deg_to_rad(360.0 / flower_data.amount_of_petals))
			loops1 += 1
		loops += 1
		st.set_color(Color(flower_data.petal_color * (1.0 - float(loops) / flower_data.layers_of_petals) + flower_data.petal_color_change * (float(loops) / flower_data.layers_of_petals), 1))
	pass
