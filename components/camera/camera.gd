class_name Camera
extends Camera2D

var boss


# Shaking intensity (from 0.0 to 1.0)
@export var trauma := 0.0
# Exponent for power of shaking strength
@export var trauma_power := 2.0
# Put the shaking strength trauma as a power exponent trauma_power
@export var amount := 0.0
# Shaking intensity that decays in 1 second
# Note that if it is less than 0.0, the shaking will last forever
@export var decay := 0.8
# Maximum shaking width
# Hold each value in x-axis direction and y-axis direction as one data in Vector2 type
@export var max_offset := Vector2(36, 64) # display ratio is 16 : 9
# Maximum angle of rotation (in radians)
@export var max_roll := 0.1

func _process(delta: float) -> void:
	if (trauma > 0):
		# Decay the intensity of the shaking
		trauma = max(trauma - decay * delta, 0)
		# Call a method to set the shaking width and rotation angle for rough shake
		# Call this method every frame to express screen shake
		rough_shake()

# Method to set the shake width and rotation angle of rough shake
func rough_shake() -> void:
	# Amount is a cumulative value of the shaking intensity
	# The closer the intensity of the shaking to 0, the smaller the value becomes when powered
	amount = pow(trauma, trauma_power)
	# rotation angle = max_roll * amount * trauma power * random value from -1 to 1
	rotation = max_roll * amount * randf_range(-1, 1)
	# x-axis swing width = maximum swing width in x-axis direction * swing strength multiplied by power * random value between -1 and 1
	var x_offset = max_offset.x * amount * randf_range(-1, 1)
	# y-axis amplitude = max_offset.x * amount * rand_range(-1, 1) * random value between -1 and 1
	var y_offset = max_offset.y * amount * randf_range(-1, 1)
	offset = Vector2(x_offset, y_offset);
	

func set_camera_shake(add_trauma := 0.5) -> void:
	# Methods to set trauma
	# Add the value of the argument add_trauma to the current trauma value
	# Set trauma to 1.0 if it is greater than or equal to 1.0
	trauma = min(trauma + add_trauma, 1.0)
