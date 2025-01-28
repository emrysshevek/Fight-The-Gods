class_name PlayerSimpleAttackState
extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
    player.moveable = false
    player.moving = false
    player.ap.play("simple_attack")
    player.ap.animation_finished.connect(_on_animation_finished)

func exit() -> void:
    player.ap.animation_finished.disconnect(_on_animation_finished)

func _on_animation_finished(_name: StringName) -> void:
    finished.emit(IDLE)
