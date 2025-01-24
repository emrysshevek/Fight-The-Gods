class_name PlayerFloatState
extends PlayerState

@export var fall_speed_influence = .1

func enter(_previous_state_path: String, _data := {}) -> void:
	player.grounded = false

func physics_update(delta: float) -> void:
	handle_transition()

	if Input.is_action_pressed("jump"):
		player.gravity =  player.get_gravity() * (1 - fall_speed_influence)
	elif Input.is_action_pressed("crouch"):
		player.gravity = player.get_gravity() * (1 + fall_speed_influence)
	else:
		player.gravity = player.get_gravity()
	
	var direction := Input.get_axis("left", "right")
	if direction != 0.0:
		player.velocity.x = move_toward(player.velocity.x, direction * player.max_speed, player.air_acceleration * delta)
		player.moving = true
	else:
		player.moving = false

func handle_transition() -> void:
	if player.is_on_floor():
		finished.emit(LAND)
	elif Input.is_action_just_pressed("dash"):
		finished.emit(DASH)
