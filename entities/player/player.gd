class_name Player
extends Entity

@export var dash_speed := 1000.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		print(gravity)
		velocity.y = move_toward(velocity.y, max_fall_speed, gravity.y * delta)

	if (
		not flipped and Input.is_action_just_pressed("left")
		or flipped and Input.is_action_just_pressed("right")
	):
		flip()

	move_and_slide()

func flip() -> void:
	scale.x *= -1
	flipped = !flipped