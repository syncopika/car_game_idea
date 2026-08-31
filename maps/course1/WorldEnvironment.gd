extends WorldEnvironment

export var sky_top_gradient: Gradient
export var sky_horizon_gradient: Gradient

# ambient energies
var daytime_ambient_energy = 1.0
var nighttime_ambient_energy = 0.05

func _process(_delta):
	if Global.time_of_day_sky:
		var curr_time = OS.get_time()
		var curr_hour = curr_time.hour
		update_lighting(curr_hour)

func _ready():
	if Global.time_of_day_sky:
		var curr_time = OS.get_time()
		var curr_hour = curr_time.hour
		update_lighting(curr_hour)
	else:
		print("no time-of-day lighting")
	
func update_lighting(hour):
	var env = get("environment")
	if env != null:
		var sky = env.get("background_sky")
		if sky != null and sky is ProceduralSky:
			# sample the sky color based on time from the gradients - sample() not available in Godot 3
			var day_fraction = hour / 24.0 # between 0 and 1
			sky.sky_top_color = sky_top_gradient.interpolate(day_fraction)
			sky.sky_horizon_color = sky_horizon_gradient.interpolate(day_fraction)
			
			# normalize time to an angle between 0 and 360 degrees
			var sun_angle = (hour / 24.0) * 360.0 # in degrees
			
			var latitude = 90.0 - sun_angle
			
			if latitude < -90.0:
				latitude = -180.0 - latitude # this wraps the sun underneath the earth at night
				
			sky.sun_latitude = latitude
			
			# adjust ambient light energy
			var blend_weight = (sin((hour / 24.0) * (2 * PI) - (2 / PI)) + 1.0) / 2.0
			env.ambient_light_energy = lerp(nighttime_ambient_energy, daytime_ambient_energy, blend_weight)

