extends Node

func _ready():
	$"MarginContainer/TextureButton".connect("pressed", self, "_back_btn_pressed")

func _back_btn_pressed():
	# go back to main menu
	print("going back to main menu")
	get_tree().change_scene("res://ui/main_menu/menu.tscn")
	get_tree().paused = false

func children():
	# return all elements in the scene
	var scene_elements = [$"MarginContainer"]
	for child in $"MarginContainer".get_children():
		scene_elements.append(child)
	return scene_elements
