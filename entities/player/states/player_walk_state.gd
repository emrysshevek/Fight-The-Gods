class_name PlayerWalkState
extends PlayerState

var direction := 0.0

func physics_update(delta: float) -> void:
    direction = Input.get_axis("left", "right")
    if direction:
        player.velocity.x = move_toward(player.velocity.x, direction * player.max_speed, player.ground_acceleration * player.MOVE_SNAP * delta)

    handle_transition()

func handle_transition() -> void:
    if not player.is_on_floor():
        finished.emit(FLOAT)
    elif direction == 0.0:
        finished.emit(IDLE)
    elif Input.is_action_just_pressed("jump"):
        finished.emit(JUMP)
    elif Input.is_action_just_pressed("crouch"):
        finished.emit(CROUCH)
    elif Input.is_action_just_pressed("dash"):
        finished.emit(DASH)
    