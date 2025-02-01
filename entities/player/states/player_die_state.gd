class_name PlayerDieState
extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
    player.moveable = false
    player.ap.play("die")
    player.set_collision_mask_value(1, true)

func handle_entity_died() -> void:
    pass