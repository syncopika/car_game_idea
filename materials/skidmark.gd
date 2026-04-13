extends Spatial

func _ready():
	var timer = Timer.new()
	timer.wait_time = 1.0 # 1 sec
	timer.one_shot = true
	timer.autostart = true
	timer.connect("timeout", self, "_on_timeout")
	add_child(timer)
	
func _on_timeout():
	queue_free()

