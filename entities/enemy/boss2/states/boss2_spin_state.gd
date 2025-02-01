class_name Boss2SpinState
extends Boss2State

func enter(_previous_state_path: String, _data := {}) -> void:
    boss.ap.play("kneel")
    Globals.spin_ended.connect(_stand)

func exit() -> void:
    Globals.spin_ended.disconnect(_stand)

func _stand() -> void:
    boss.ap.play("stand")
    boss.ap.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(_name: StringName) -> void:
    boss.ap.animation_finished.disconnect(_on_animation_finished)
    finished.emit(IDLE)

