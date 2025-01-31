class_name Boss2
extends Enemy

signal stomp()
signal slam()

@export var left_target: Node2D
@export var middle_target: Node2D
@export var right_target: Node2D

func _physics_process(delta: float) -> void:
    gravity = get_gravity()
    super._physics_process(delta)

func _on_step() -> void:
    stomp.emit()

func _on_slam() -> void:
    slam.emit()