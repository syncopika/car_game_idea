# https://www.youtube.com/watch?v=zXLpitpFC6E - Godot Car Tutorial by SRCoder

extends VehicleBody

var max_rpm = 600
var max_torque = 200
var last_rpm = 0

var skidmark_script = load("res://materials/skidmark.gd")
var texture = preload("res://models/r8/r8_texture.png")

func _ready():
	print("hello world")
	# TODO: make this material-setting code a global function?
	var car_mat = Global.selected_car_material
	var mat
	if car_mat == "normal":
		mat = preload("res://models/r8/Material.material")
	elif car_mat == "inverted":
		mat = preload("res://materials/inverted_shader.tres")
		mat.set_shader_param("diffuse", texture)
	elif car_mat == "outline":
		mat = preload("res://materials/outline_shader.tres")
		mat.set_shader_param("diffuse", texture)
	
	if mat:
		print("setting material to ", car_mat)
		$"body".set_surface_material(0, mat)

func _physics_process(delta):
	steering = lerp(steering, Input.get_axis("right", "left") * 0.3, 5 * delta);

	var acceleration = Input.get_axis("back", "forward")
	var deceleration = -1 if Input.is_action_pressed("brake") else 1;
	
	# calculate rpm for each back wheel and use that to calculate their engine force
	var back_left_rpm = $back_left_wheel.get_rpm()
	var back_right_rpm = $back_right_wheel.get_rpm()
	
	if Input.is_action_pressed("drift"):
		$back_left_wheel.wheel_friction_slip = 0.5
		$back_right_wheel.wheel_friction_slip = 0.5
		# TODO: adjust something else so the car can follow through with the drift and not slow down?
		
		# add skidmarks :D
		add_skidmarks()
	else:
		# gradually set friction slip back to default value of 10.5
		$back_left_wheel.wheel_friction_slip = lerp($back_left_wheel.wheel_friction_slip, 10.5, delta)
		$back_right_wheel.wheel_friction_slip = lerp($back_right_wheel.wheel_friction_slip, 10.5, delta)
	
	# if going backwards, the rpm is negative and when decelerating, the rpm gets closer to 0.
	# if going forwards, the rpm is positive and when decelerating, the rpm gets closer to 0.
	# therefore, we know when to totally stop applying any engine force (e.g. complete stop) when rpm reaches the 0 threshold
	# from either positive or negative sides.
	# seems to work fine lol. I can't think of a better way atm to do this other than keeping track of the last seen rpm.
	if Input.is_action_pressed("brake") and ((last_rpm < 0 and back_left_rpm > 0) or (last_rpm > 0 and back_left_rpm < 0)):
		# once we slow down to 0 rpm, stay there
		$back_left_wheel.engine_force = 0.0
		$back_right_wheel.engine_force = 0.0
		return
	
	last_rpm = back_left_rpm
	
	# using abs() for the rpm value is important, since rpm could be negative (and that's not necessarily important in this context
	# for calculating engine force I think), which could give us really big numbers that would cause a large acceleration.
	var back_left_wheel_engine_force = acceleration * deceleration * max_torque * (1 - (abs(back_left_rpm) / max_rpm))
	var back_right_wheel_engine_force = acceleration * deceleration * max_torque * (1 - (abs(back_right_rpm) / max_rpm))
	
	$back_left_wheel.engine_force = back_left_wheel_engine_force
	$back_right_wheel.engine_force = back_right_wheel_engine_force
	
	#if back_left_wheel_engine_force != 0:
	#	print("direction: %d, back left wheel engine force: %d, rpm: %d" % [acceleration, back_left_wheel_engine_force, back_left_rpm])
	#	print("direction: %d, back right wheel engine force %d, rpm: %d" % [acceleration, back_right_wheel_engine_force, back_right_rpm])
	
	var material = $"body".get_active_material(0)
	if Input.get_axis("right", "left") != 0:
		# if turning, make the car body slightly transparent
		# note that shadermaterial has no albedo_color property so we need to verify albedo_color exists
		# make sure the material has transparent flag enabled + depth draw mode set to "always"
		if Global.transparency_on && "albedo_color" in material:
			material.flags_transparent = true
			material.albedo_color.a = 0.5
	else:
		if "albedo_color" in material:
			material.flags_transparent = false
			material.albedo_color.a = 1.0


func add_skidmarks():
	var yOffset = 0.3 # TODO: raycast down from wheels to know y-axis placement?
	var root = get_tree().current_scene
	
	var left_skidmark = $"skidmark".duplicate()
	left_skidmark.set_script(skidmark_script)
	root.add_child(left_skidmark)
	left_skidmark.visible = true
	left_skidmark.global_transform.origin = $back_left_wheel.global_transform.origin
	left_skidmark.global_transform.basis = $"skidmark".global_transform.basis # important to use the basis of the original mesh!
	left_skidmark.global_translate(Vector3(0.1, -yOffset, 0.2))
	#left_skidmark.transform.basis.z = $front_left_wheel.transform.basis.y
	#left_skidmark.global_transform.basis.z = transform.basis.y
	
	var right_skidmark = $"skidmark2".duplicate()
	right_skidmark.set_script(skidmark_script)
	root.add_child(right_skidmark)
	right_skidmark.visible = true
	right_skidmark.global_transform.origin = $back_right_wheel.global_transform.origin
	right_skidmark.global_transform.basis = $"skidmark".global_transform.basis
	right_skidmark.global_translate(Vector3(-0.1, -yOffset, 0.2))
