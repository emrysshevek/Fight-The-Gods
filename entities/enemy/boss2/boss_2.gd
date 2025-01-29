class_name Boss2
extends Enemy

var next_position := ""

func _physics_process(delta: float) -> void:
    gravity = get_gravity()
    super._physics_process(delta)