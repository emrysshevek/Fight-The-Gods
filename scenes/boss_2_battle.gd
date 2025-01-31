extends Node2D

@export var spin_speed := 1.0

@onready var boss: Boss2 = $Enemy
@onready var camera: Camera = $Camera
@onready var world: Node2D = $world

func _ready() -> void:
	# boss.stomp.connect(_on_boss_stomp)
	boss.slam.connect(_on_boss_slam)

func _on_boss_stomp() -> void:
	camera.add_trauma(.65)

func _on_boss_slam() -> void:
	# print("Boss slammed stage...spin time!")
	var spin_amount = world.rotation + randi_range(3,4) * (PI)
	var spin_duration = (spin_amount - world.rotation) * (1 / spin_speed)
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(world, "rotation", spin_amount, spin_duration)
