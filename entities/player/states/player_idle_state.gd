class_name PlayerIdleState
extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	player.grounded = true

func physics_update(delta: float) -> void:
	player.velocity.x = move_toward(player.velocity.x, 0, player.ground_friction * player.MOVE_SNAP * delta)
	handle_transition()

func handle_transition() -> void:
	if not player.is_on_floor():
		finished.emit(FLOAT)
	elif Input.is_action_just_pressed("dash"):
		finished.emit(DASH)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMP)
	elif Input.is_action_pressed("crouch"):
		finished.emit(CROUCH)
	elif Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		finished.emit(WALK)


	
	
