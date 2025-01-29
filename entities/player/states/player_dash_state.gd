class_name PlayerDashState
extends PlayerState

@export var dash_duration := .2
@export var total_duration := .3
@export var deceleration := 5000.0

var dir := 0.0
var elapsed := 0.0

func enter(_previous_state_path: String, _data := {}) -> void:
    player.moveable = false
    player.moving = false
    player.damageable = false

    dir = Input.get_axis("left", "right")
    if dir == 0:
        dir = -1 if player.flipped else 1
    
    player.gravity = Vector2.ZERO
    player.velocity = Vector2(player.dash_speed * dir, 0)
    elapsed = 0
    player.ap.play("dash")
    player.ap.animation_finished.connect(_on_animation_finished)

func exit() -> void:
    player.damageable = true
    player.gravity = player.get_gravity()
    player.ap.animation_finished.disconnect(_on_animation_finished)

func physics_update(delta: float) -> void:
    player.gravity = Vector2.ZERO
    elapsed += delta

    if elapsed >= dash_duration:
        player.velocity.x = move_toward(player.velocity.x, player.max_speed * dir / 2, deceleration * delta)
    
func _on_animation_finished(_anim_name: StringName) -> void:
    handle_transition([IDLE, FLOAT])
