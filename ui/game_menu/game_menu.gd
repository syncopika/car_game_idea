extends Node

func _ready():
	$"TextureButton".connect("pressed", self, "_back_btn_pressed")

func _back_btn_pressed():
	# go back to main menu
	get_tree().change_scene("res://ui/menu/menu.tscn")
