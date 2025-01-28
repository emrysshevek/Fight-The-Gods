class_name PlayerInitState
extends PlayerState

func physics_update(_delta: float) -> void:
    player.moveable = true
    player.moving = false
    if player.is_on_floor():
        player.grounded = true
        finished.emit(IDLE)
    else:
        player.grounded = false
        finished.emit(FLOAT)