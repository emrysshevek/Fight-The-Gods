class_name PlayerWalkState
extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
    player.moveable = true
    player.moving = true
    player.ap.play("walk")
    player.ap.speed_scale = 1.25

func exit() -> void:
    player.moving = false
    player.ap.speed_scale = 1

func physics_update(_delta: float) -> void:
    if not player.is_on_floor():
        finished.emit(FLOAT)
        return

    if !player.moving:
        finished.emit(IDLE)
        return

    if handle_transition([JUMP, CROUCH, DASH, SIMPLE_ATTACK, HEAVY_ATTACK]) == "":
        return