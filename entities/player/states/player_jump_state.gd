class_name PlayerJumpState
extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
    player.grounded = false

func physics_update(_delta: float) -> void:
    player.velocity.y -= player.jump_velocity
    finished.emit(FLOAT)