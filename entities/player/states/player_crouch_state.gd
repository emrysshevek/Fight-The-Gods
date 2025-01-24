class_name PlayerCrouchState
extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
    player.scale.y = .5
    player.moving = false

func physics_update(_delta: float) -> void:
    if not Input.is_action_pressed("crouch"):
        finished.emit(IDLE)

func exit() -> void:
    player.scale.y = 1
