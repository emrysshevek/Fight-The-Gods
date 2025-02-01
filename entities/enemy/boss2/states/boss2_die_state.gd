class_name Boss2DieState
extends Boss2State

func enter(_previous_state_path: String, _data := {}) -> void:
	boss.ap.play("die")

func handle_entity_died() -> void:
	pass
