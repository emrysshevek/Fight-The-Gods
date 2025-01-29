class_name PlayerJumpState
extends PlayerState

var in_jump: bool = false

func enter(_previous_state_path: String, _data := {}) -> void:
    player.moveable = true
    player.grounded = false
    player.ap.play("jump")
    player.ap.animation_finished.connect(_on_animation_finished)
    player.velocity.y = -player.jump_velocity
    in_jump = true

func exit() -> void:
    in_jump = false
    player.ap.animation_finished.disconnect(_on_animation_finished)

func physics_update(_delta: float) -> void:
    if player.is_on_floor():
        finished.emit(LAND)
        return

    handle_transition([DASH])

func _on_animation_finished(anim_name: StringName) -> void:
    assert(str(anim_name) == "jump", "Incorrect animation [" + str(anim_name) + "] playing during jump state. Expected " + "jump" )
    finished.emit(FLOAT)
