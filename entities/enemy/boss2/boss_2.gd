class_name Boss2
extends Enemy

signal stomp()
signal slam(direction: int)

@export var left_target: Node2D
@export var middle_target: Node2D
@export var right_target: Node2D

func _physics_process(delta: float) -> void:
    gravity = get_gravity()
    super._physics_process(delta)

func _on_step() -> void:
    stomp.emit()

func _on_slam() -> void:
    if global_position.distance_to(left_target.global_position) < global_position.distance_to(right_target.global_position):
        slam.emit(-1)
    else:
        slam.emit(1)