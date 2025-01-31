extends Node2D

@export var spin_speed := 1.0

@onready var boss: Boss2 = $Enemy
@onready var camera: Camera = $Camera
@onready var world: Node2D = $world

var stage_orientation = "horizontal"

func _ready() -> void:
	camera.position = $CameraPositions/horizontal.position
	# boss.stomp.connect(_on_boss_stomp)
	boss.slam.connect(_on_boss_slam)

# func _on_boss_stomp() -> void:
# 	camera.add_trauma(.65)

func _on_boss_slam() -> void:
	# print("Boss slammed stage...spin time!")

	if stage_orientation == "horizontal":
		stage_orientation = "vertical"
	else:
		stage_orientation = "horizontal"

	camera.position = Vector2.ZERO
	camera.zoom = Vector2(1.25, 1.25)

	_unfreeze_objects()
	
	var spin_amount = randi_range(3,4) * (PI) + (PI/2)
	var spin_duration = spin_amount * (1 / spin_speed)

	var tweener = create_tween()
	tweener.set_parallel()

	var spin_tween = tweener.tween_property(world, "rotation", world.rotation + spin_amount, spin_duration)
	spin_tween.set_ease(Tween.EASE_OUT)
	spin_tween.set_trans(Tween.TRANS_SINE)

	# tweener.tween_property(camera, "position", Vector2.ZERO, .1)
	# tweener.tween_property(camera, "zoom", Vector2(1.25, 1.25), .1)

	get_tree().create_timer(spin_duration).timeout.connect(_on_spin_ended)
	

func _on_spin_ended() -> void:
	var tweener = create_tween()
	tweener.set_parallel()
	tweener.set_trans(Tween.TRANS_CUBIC)
	tweener.set_ease(Tween.EASE_OUT)

	var next_cam_pos: Vector2 = $CameraPositions/horizontal.position if stage_orientation == "horizontal" else $CameraPositions/vertical.position
	
	tweener.tween_property(camera, "position", next_cam_pos, .5)
	tweener.tween_property(camera, "zoom", Vector2(1, 1), .5)

func _unfreeze_objects() -> void:
	for object: RigidBody2D in $Objects.get_children():
		print(object)
		object.freeze = false
	for object: RigidBody2D in $Decorations.get_children():
		print(object)
		object.freeze = false