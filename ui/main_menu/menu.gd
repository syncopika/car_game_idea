extends Control

var free_play_scene = preload("res://game.tscn")
var customize_car_scene = preload("res://ui/car_customization/car_customization.tscn")
var options_scene = preload("res://ui/options/options.tscn")

func _ready():
	var course_1_btn = $MarginContainer/VBoxContainer/Course1Btn
	var course_2_btn = $MarginContainer/VBoxContainer/Course2Btn
	var options_btn = $MarginContainer/VBoxContainer/OptionsBtn
	var customize_car_btn = $MarginContainer/VBoxContainer/CustomizeCarBtn
	
	course_1_btn.connect("pressed", self, "_course_1_btn_pressed")
	options_btn.connect("pressed", self, "_options_btn_pressed")
	customize_car_btn.connect("pressed", self, "_customize_car_btn_pressed")

func _course_1_btn_pressed():
	get_tree().change_scene_to(free_play_scene)
	
func _options_btn_pressed():
	get_tree().change_scene_to(options_scene)
	
func _customize_car_btn_pressed():
	get_tree().change_scene_to(customize_car_scene)

