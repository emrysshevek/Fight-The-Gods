extends Node2D

@export var spin_speed := 1.0

@onready var boss: Boss2 = $Enemy
@onready var player: Player = $Player
@onready var camera: Camera = $Camera
@onready var stage: Node2D = $stage

var stage_orientation = "horizontal"

func _ready() -> void:
	camera.position = $CameraPositions/horizontal.position
	# boss.stomp.connect(_on_boss_stomp)
	boss.slam.connect(_on_boss_slam)
	player.died.connect(_on_player_died)
	boss.died.connect(_on_boss_died)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause()

func pause() -> void:
	# get_tree().paused = true
	$UILayer/Pause.open()

func _on_player_died(_which_entity: Entity) -> void:
	# game_over.position.y += 956
	$UILayer/LoseScreen.show()

	# var tweener: Tween = create_tween().set_parallel()

	# var screen_tween = tweener.tween_property(game_over, "position", Vector2.ZERO, 2)
	# screen_tween.set_trans(Tween.TRANS_SPRING)


func _on_boss_died(_which_entity: Entity) -> void:
	$UILayer/WinScreen.show()


# func _on_boss_stomp() -> void:
# 	camera.add_trauma(.65)

func _on_boss_slam(direction: int) -> void:
	# print("Boss slammed stage...spin time!")
	Globals.start_spin()

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

	var spin_tween = tweener.tween_property(stage, "rotation", stage.rotation + (direction * spin_amount), spin_duration)
	spin_tween.set_ease(Tween.EASE_OUT)
	spin_tween.set_trans(Tween.TRANS_SINE)

	# tweener.tween_property(camera, "position", Vector2.ZERO, .1)
	# tweener.tween_property(camera, "zoom", Vector2(1.25, 1.25), .1)

	get_tree().create_timer(spin_duration).timeout.connect(_on_spin_ended)
	

func _on_spin_ended() -> void:
	Globals.end_spin()
	
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
