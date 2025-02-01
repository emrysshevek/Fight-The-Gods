class_name PlayerCrouchState
extends PlayerState

const END_STARTUP_FRAME = 10
const FPS = 40

@export var parry_duration := 1.0

func enter(_previous_state_path: String, _data := {}) -> void:
    player.moving = false
    player.moveable = false
    player.ap.play("crouch")
    player.ap.animation_finished.connect(_on_animation_finished)
    

func exit() -> void:
    player.ap.animation_finished.disconnect(_on_animation_finished)

func physics_update(_delta: float) -> void:
    if not Input.is_action_pressed("crouch"):
        finished.emit(IDLE)
    else:
        handle_transition([
            JUMP,
            DASH,
            SIMPLE_ATTACK,
            HEAVY_ATTACK
        ])


func _on_animation_finished(_name: StringName) -> void:
    player.ap.seek(END_STARTUP_FRAME * 1.0/FPS)
    player.ap.play("crouch")