extends TextureButton

var customize_car_scene = preload("res://ui/car_customization/car_customization.tscn")

func _pressed():
	get_tree().change_scene_to(customize_car_scene)
