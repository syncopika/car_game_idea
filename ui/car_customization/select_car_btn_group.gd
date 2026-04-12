extends HBoxContainer

# this is a script variable so we need to specify
# which button group in the Inspector for this component
# the script is attached to.
export(ButtonGroup) var button_group

onready var viewport = get_parent().get_parent().get_node("./ViewportContainer")

func _ready():
	for button in button_group.get_buttons():
		button.connect("pressed", self, "_on_button_pressed")
	#print(viewport)

func _on_button_pressed():
	var pressed_btn = button_group.get_pressed_button()
	if pressed_btn:
		# TODO: can we make an enum for the possible car materials?
		Global.selected_car = pressed_btn.text
		
		# show selected car in viewport
		viewport.get_child(0).get_child(0).change_car_model()
