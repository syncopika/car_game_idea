extends HSlider

# this function is connected to the slider component
# and relies on the value_changed signal
# via HSlider -> Node tab in right sidebar -> see value_changed(value: float)
func _on_HSlider_value_changed(value):
	#print("value: ", value)
	var valueLabelNode = get_node("../Label2")
	valueLabelNode.text = str(value) 
