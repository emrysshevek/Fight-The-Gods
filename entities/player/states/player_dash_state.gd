class_name PlayerDashState
extends PlayerState

@export var dash_duration := .2
@export var total_duration := .3
@export var deceleration := 5000.0

var dir := 0.0
var elapsed := 0.0

func enter(_previous_state_path: String, _data := {}) -> void:
    player.moving = false
    dir = Input.get_axis("left", "right")
    if dir == 0:
        dir = -1 if player.flipped else 1
    
    player.gravity = Vector2.ZERO
    player.velocity = Vector2(player.dash_speed * dir, 0)
    elapsed = 0

func exit() -> void:
    player.gravity = player.get_gravity()

func physics_update(delta: float) -> void:
    player.gravity = Vector2.ZERO
    elapsed += delta

    if elapsed >= total_duration:
        handle_transition()
    elif elapsed >= dash_duration:
        player.velocity.x = move_toward(player.velocity.x, player.max_speed, deceleration * delta)

func handle_transition() -> void:
    if player.is_on_floor():
        finished.emit(IDLE)
    else:
        finished.emit(FLOAT)
    
