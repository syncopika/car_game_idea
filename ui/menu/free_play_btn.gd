extends TextureButton

var free_play_scene = preload("res://game.tscn")

func _pressed():
	get_tree().change_scene_to(free_play_scene)
