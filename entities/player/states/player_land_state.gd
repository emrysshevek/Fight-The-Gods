class_name PlayerLandState
extends PlayerState

func physics_update(_delta: float) -> void:
    player.grounded = true
    finished.emit(IDLE)