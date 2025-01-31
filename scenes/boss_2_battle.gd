extends Node2D


@onready var boss: Boss2 = $Enemy
@onready var camera: Camera = $Camera
@onready var world: Node2D = $world

func _ready() -> void:
	boss.stomp.connect(_on_boss_stomp)
	boss.slam.connect(_on_boss_slam)

func _on_boss_stomp() -> void:
	camera.add_trauma(.65)

func _on_boss_slam() -> void:
	# print("Boss slammed stage...spin time!")
	var spin_amount = world.rotation + randi_range(10, 14) * (PI/2)
	var tween = create_tween()
	tween.tween_property(world, "rotation", spin_amount, 3)
	tween.set_ease(Tween.EASE_OUT)
	

