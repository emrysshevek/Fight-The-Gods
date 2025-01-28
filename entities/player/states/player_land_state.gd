class_name PlayerLandState
extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
    player.moveable = false
    player.grounded = false
    player.ap.play("land")
    player.ap.animation_finished.connect(_on_animation_finished)

func exit() -> void:
    player.ap.animation_finished.disconnect(_on_animation_finished)

func physics_update(_delta: float) -> void:
    player.grounded = true

func _on_animation_finished(_name: StringName) -> void:
    finished.emit(IDLE)