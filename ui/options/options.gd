extends Control

func _ready():
	var music_volume_slider = $VBoxContainer/HBoxContainer/musicVolume
	var effects_volume_slider = $VBoxContainer/HBoxContainer2/effectsVolume
	var toggle_car_transparency_btn = $VBoxContainer/toggleCarTransparency
	var back_button = $VBoxContainer/backButton
	
	music_volume_slider.connect("value_changed", self, "_on_music_value_changed")
	effects_volume_slider.connect("value_changed", self, "_on_effects_value_changed")
	toggle_car_transparency_btn.connect("pressed", self, "_on_toggle_transparency_pressed")
	back_button.connect("pressed", self, "_back_btn_pressed")

	music_volume_slider.value = Global.music_volume_db
	effects_volume_slider.value = Global.effects_volume_db
	toggle_car_transparency_btn.pressed = Global.transparency_on

func _on_music_value_changed(value):
	var valueLabelNode = get_node("./VBoxContainer/HBoxContainer/Label2")
	valueLabelNode.text = str(value)
	Global.music_volume_db = value
	
func _on_effects_value_changed(value):
	var valueLabelNode = get_node("./VBoxContainer/HBoxContainer2/Label2")
	valueLabelNode.text = str(value)
	Global.effects_volume_db = value
	
func _on_toggle_transparency_pressed():
	Global.transparency_on = !Global.transparency_on

func _back_btn_pressed():
	get_tree().change_scene("res://ui/main_menu/menu.tscn")
