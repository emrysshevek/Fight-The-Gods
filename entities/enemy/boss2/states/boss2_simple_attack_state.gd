class_name Boss2SimpleAttackState
extends Boss2State

func enter(_previous_state_path: String, _data := {}) -> void:
    boss.ap.play("simple_attack")
    boss.ap.animation_finished.connect(_on_animation_finished)

func exit() -> void:
    boss.ap.animation_finished.disconnect(_on_animation_finished)

func _on_animation_finished(_name: StringName) -> void:
    finished.emit(IDLE)