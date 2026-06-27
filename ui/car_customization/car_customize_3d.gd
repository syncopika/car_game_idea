extends Spatial

var gtr = preload("res://models/gtr/gtr-demo.tscn")
var r8 = preload("res://models/r8/r8-demo.tscn")
var revuelto = preload("res://models/revuelto/revuelto-demo.tscn")

var gtr_texture = preload("res://models/gtr/gtr_texture.png")
var r8_texture = preload("res://models/r8/r8_texture.png")
var revuelto_texture = preload("res://models/revuelto/revuelto_texture.png")

func get_curr_car_texture():
	if Global.selected_car == "gtr":
		return gtr_texture
	elif Global.selected_car == "r8":
		return r8_texture
	elif Global.selected_car == "revuelto":
		return revuelto_texture

func _process(delta):
	$"selectedCarContainer".rotate_y(0.5 * delta)

func change_car_model():
	for child in $"selectedCarContainer".get_children():
		child.queue_free()
	
	var instance
	if Global.selected_car == "gtr":
		instance = gtr.instance()
	elif Global.selected_car == "r8":
		instance = r8.instance()
	elif Global.selected_car == "revuelto":
		instance = revuelto.instance()
		
	if instance:
		$"selectedCarContainer".add_child(instance)
		instance.global_transform.origin = Vector3(0, 0, 0)

func update_car_material():
	var car_mat = Global.selected_car_material
	var mat
	if car_mat == "normal":
		mat = load("res://models/%s/Material.material" % Global.selected_car)
	elif car_mat == "inverted":
		mat = preload("res://materials/inverted_shader.tres")
		var tex = get_curr_car_texture()
		mat.set_shader_param("diffuse", tex)
	elif car_mat == "outline":
		mat = preload("res://materials/outline_shader.tres")
		var tex = get_curr_car_texture()
		mat.set_shader_param("diffuse", tex)

	if mat:
		#print("setting material to ", car_mat)
		var car_body = $"selectedCarContainer".get_child(0).get_child(0) # 0th child should be the vehiclebody parent and its 0th child should be the car body mesh
		#print(car_body)
		car_body.set_surface_material(0, mat)

func _ready():
	change_car_model()
