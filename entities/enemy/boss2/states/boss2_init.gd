class_name Boss2InitState
extends Boss2State

func physics_update(_delta: float) -> void:
    finished.emit(IDLE)
