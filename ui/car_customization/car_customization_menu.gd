extends Control

# this is a script variable so we need to specify
# which button group in the Inspector for this component
# the script is attached to.
export(ButtonGroup) var material_select_button_group
export(ButtonGroup) var car_select_button_group

onready var viewport = $MarginContainer/HSplitContainer/ViewportContainer/Viewport
onready var audio = $AudioStreamPlayer

func _ready():
	# set up material select radio buttons
	for button in material_select_button_group.get_buttons():
		button.connect("pressed", self, "_on_material_select_button_pressed")
		
		if Global.selected_car_material == button.text:
			button.pressed = true
	
	# set up car select radio buttons
	for button in car_select_button_group.get_buttons():
		button.connect("pressed", self, "_on_car_select_button_pressed")

		if Global.selected_car == button.text:
			button.pressed = true
	
	audio.volume_db = Global.music_volume_db

func _on_material_select_button_pressed():
	var pressed_btn = material_select_button_group.get_pressed_button()
	if pressed_btn:
		# TODO: can we make an enum for the possible car materials?
		Global.selected_car_material = pressed_btn.text
		viewport.get_child(0).update_car_material()

func _on_car_select_button_pressed():
	var pressed_btn = car_select_button_group.get_pressed_button()
	if pressed_btn:
		# TODO: can we make an enum for the possible car materials?
		Global.selected_car = pressed_btn.text
		viewport.get_child(0).change_car_model()
		
		
		
