# very helpful for track creation in Godot
# https://www.youtube.com/watch?v=Yvy8vQ-5O_w (Godot Vehicle Tutorial Part 2 - Building a track) by Bastiaan Olij

extends Spatial

#onready var car = $"car"
#onready var camera = $"car/camera_pivot"
var car

var gtr = preload("res://models/gtr/gtr-demo.tscn")
var r8 = preload("res://models/r8/r8-demo.tscn")
var revuelto = preload("res://models/revuelto/revuelto-demo.tscn")

var game_menu_scene = preload("res://ui/game_menu/game_menu.tscn")
var game_menu

var is_paused = false
var camera_pos = "behind" # behind car
var initial_car_pos
var initial_car_rot

onready var audio = $AudioStreamPlayer

func _unhandled_input(event: InputEvent):
	if !car:
		return
	
	var camera = car.get_node("camera_pivot")
		
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_F1:
			# change camera position
			if camera_pos == "behind":
				camera_pos = "front"
				camera.translate(Vector3(0, 0, 6))
			else:
				camera_pos = "behind"
				camera.translate(Vector3(0, 0, -6))
		if event.scancode == KEY_R:
			# reset car position/orientation with R key
			car.transform.origin = initial_car_pos
			car.rotation = initial_car_rot
			car.linear_velocity = Vector3.ZERO
			car.angular_velocity = Vector3.ZERO
		if event.scancode == KEY_P || event.scancode == KEY_ESCAPE:
			# pause the game
			is_paused = !is_paused
			get_tree().paused = is_paused
			
			# show game menu
			var game_menu_children = game_menu.children()
			for child in game_menu_children:
				child.visible = !child.visible
				
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				print("honk honk")
				$car_horn.volume_db = Global.effects_volume_db
				$car_horn.play()
			else:
				$car_horn.stop()
			
func _ready():
	#print(OS.get_time())
	var selected_car_model = gtr
	if Global.selected_car == "r8":
		selected_car_model = r8
	elif Global.selected_car == "revuelto":
		selected_car_model = revuelto
		
	if Global.music_on:
		audio.playing = true
		audio.volume_db = Global.music_volume_db
	else:
		audio.playing = false
	
	var car_instance = selected_car_model.instance()
	add_child(car_instance)
	car_instance.global_transform.origin = Vector3(60, 0, 0)
	car = car_instance
	
	game_menu = game_menu_scene.instance()
	add_child(game_menu)

	initial_car_pos = car.global_transform.origin
	initial_car_rot = car.transform.basis.get_euler()
