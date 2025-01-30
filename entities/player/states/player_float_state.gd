class_name PlayerFloatState
extends PlayerState

@export var fall_speed_influence = .5

func enter(_previous_state_path: String, _data := {}) -> void:
	player.moveable = true
	player.grounded = false
	player.ap.play("float")

func physics_update(_delta: float) -> void:
	handle_transition([
		LAND,
		DASH,
	])

	if Input.is_action_pressed("jump"):
		player.gravity =  player.get_gravity() * (1 - fall_speed_influence)
	elif Input.is_action_pressed("crouch"):
		player.gravity = player.get_gravity() * (1 + fall_speed_influence)
	else:
		player.gravity = player.get_gravity()

