extends Button

var options_scene = preload("res://ui/options/options.tscn")

func _pressed():
	get_tree().change_scene_to(options_scene)
