extends Control

onready var audio = $AudioStreamPlayer

func _ready():
	var music_volume_slider = $VBoxContainer/HBoxContainer/musicVolume
	var effects_volume_slider = $VBoxContainer/HBoxContainer2/effectsVolume
	var toggle_car_transparency_btn = $VBoxContainer/toggleCarTransparency
	var back_button = $VBoxContainer/backButton
	var toggle_music_btn = $VBoxContainer/HBoxContainer3/toggleMusic
	var toggle_sound_effects_btn = $VBoxContainer/HBoxContainer4/toggleSoundEffects
	var toggle_time_of_day_sky_btn = $VBoxContainer/toggleTimeOfDaySky
	
	music_volume_slider.connect("value_changed", self, "_on_music_value_changed")
	effects_volume_slider.connect("value_changed", self, "_on_effects_value_changed")
	toggle_car_transparency_btn.connect("pressed", self, "_on_toggle_transparency_pressed")
	back_button.connect("pressed", self, "_back_btn_pressed")
	toggle_music_btn.connect("pressed", self, "_on_toggle_music_pressed")
	toggle_sound_effects_btn.connect("pressed", self, "_on_toggle_sound_effects_pressed")
	toggle_time_of_day_sky_btn.connect("pressed", self, "_on_toggle_time_of_day_sky_pressed")

	music_volume_slider.value = Global.music_volume_db
	music_volume_slider.editable = Global.music_on
	
	effects_volume_slider.value = Global.effects_volume_db
	effects_volume_slider.editable = Global.effects_on
	
	toggle_car_transparency_btn.pressed = Global.transparency_on
	toggle_music_btn.pressed = Global.music_on
	toggle_sound_effects_btn = Global.effects_on
	toggle_time_of_day_sky_btn.pressed = Global.time_of_day_sky
	
	if Global.music_on:
		audio.playing = true
		audio.volume_db = Global.music_volume_db
	else:
		audio.playing = false

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
	
func _on_toggle_music_pressed():
	# disable/enable music_volume_slider
	Global.music_on = !Global.music_on
	var music_volume_slider = $VBoxContainer/HBoxContainer/musicVolume
	music_volume_slider.editable = Global.music_on
	
func _on_toggle_sound_effects_pressed():
	Global.effects_on = !Global.effects_on
	var effects_volume_slider = $VBoxContainer/HBoxContainer2/effectsVolume
	effects_volume_slider.editable = Global.effects_on
	
func _on_toggle_time_of_day_sky_pressed():
	Global.time_of_day_sky = !Global.time_of_day_sky

func _back_btn_pressed():
	get_tree().change_scene("res://ui/main_menu/menu.tscn")
	
