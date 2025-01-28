class_name PlayerWalkState
extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
    player.moveable = true
    player.moving = true
    player.ap.play("walk")

func exit() -> void:
    player.moving = false

func physics_update(_delta: float) -> void:
    handle_transition()

func handle_transition() -> void:
    if not player.is_on_floor():
        finished.emit(FLOAT)
    elif player.moving == false:
        finished.emit(IDLE)
    elif Input.is_action_just_pressed("jump"):
        finished.emit(JUMP)
    elif Input.is_action_just_pressed("crouch"):
        finished.emit(CROUCH)
    elif Input.is_action_just_pressed("dash"):
        finished.emit(DASH)
    