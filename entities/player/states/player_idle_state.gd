class_name PlayerIdleState
extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	player.moveable = true
	player.moving = false
	player.grounded = true
	player.ap.play("idle")

func physics_update(_delta: float) -> void:
	handle_transition()

func handle_transition() -> void:
	if not player.is_on_floor():
		finished.emit(FLOAT)
	elif Input.is_action_just_pressed("dash"):
		finished.emit(DASH)
	elif Input.is_action_just_pressed("simple_attack"):
		finished.emit(SIMPLE_ATTACK)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMP)
	elif Input.is_action_pressed("crouch"):
		finished.emit(CROUCH)
	elif Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		finished.emit(WALK)


	
	
