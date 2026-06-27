extends Control

var free_play_scene = load("res://maps/course1/game.tscn")
var course2_scene = load("res://maps/course2/course2.tscn")
var customize_car_scene = load("res://ui/car_customization/car_customization.tscn")
var options_scene = load("res://ui/options/options.tscn")

func _ready():
	var course_1_btn = $MarginContainer/VBoxContainer/Course1Btn
	var course_2_btn = $MarginContainer/VBoxContainer/Course2Btn
	var options_btn = $MarginContainer/VBoxContainer/OptionsBtn
	var customize_car_btn = $MarginContainer/VBoxContainer/CustomizeCarBtn
	
	course_1_btn.connect("pressed", self, "_course_1_btn_pressed")
	course_2_btn.connect("pressed", self, "_course_2_btn_pressed")
	options_btn.connect("pressed", self, "_options_btn_pressed")
	customize_car_btn.connect("pressed", self, "_customize_car_btn_pressed")

func _course_1_btn_pressed():
	get_tree().change_scene_to(free_play_scene)
	
func _course_2_btn_pressed():
	get_tree().change_scene_to(course2_scene)
	
func _options_btn_pressed():
	get_tree().change_scene_to(options_scene)
	
func _customize_car_btn_pressed():
	get_tree().change_scene_to(customize_car_scene)

