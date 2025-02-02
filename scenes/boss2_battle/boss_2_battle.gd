extends Node2D

@export var spin_speed := 1.0

@onready var boss: Boss2 = $Enemy
@onready var player: Player = $Player
@onready var camera: Camera = $Camera
@onready var stage: Node2D = $stage

@onready var theme: AudioStream = preload("res://assets/music/Earth Boss/Lumberjack-Earth Boss_Mix_Placeholder.wav")
@onready var loop: AudioStream = preload("res://assets/music/Earth Boss/Lumberjack-Earth Boss_Loop_Placeholder.wav")

var stage_orientation = "horizontal"

func _ready() -> void:
	camera.position = $CameraPositions/horizontal.position
	boss.stomp.connect(_on_boss_stomp)
	boss.slam.connect(_on_boss_slam)
	boss.died.connect(_on_boss_died)
	player.damaged.connect(_on_player_damaged)
	player.died.connect(_on_player_died)
	AudioMixer.play(theme, loop)
	Engine.time_scale = 1

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause()

func pause() -> void:
	$UILayer/Pause.open()

func _on_player_damaged(which_entity: Entity) -> void:
	var dmg_texture: TextureRect = $UILayer/DamageTexture
	dmg_texture.self_modulate.a = 1
	dmg_texture.show()
	create_tween().tween_property(dmg_texture,'self_modulate:a', 0.0, 1)

func _on_player_died(_which_entity: Entity) -> void:
	var tween = create_tween().set_loops(1).set_trans(Tween.TRANS_CUBIC)

	var screen = $UILayer/LoseScreen
	screen.modulate.a = 0
	screen.show()

	Engine.time_scale = .1

	tween.tween_property(screen, "modulate:a", 1, .2).set_delay(1)
	# tween.tween_property(Engine, "time_scale", 1, .75)

func _on_boss_died(_which_entity: Entity) -> void:
	Globals.beat_game()
	var tween = create_tween().set_loops(1).set_trans(Tween.TRANS_CUBIC)

	var screen = $UILayer/WinScreen
	screen.modulate.a = 0
	screen.show()

	Engine.time_scale = .1

	tween.tween_property(screen, "modulate:a", 1, .2).set_delay(1)
	# tween.tween_property(Engine, "time_scale", 1, .75)

func _on_boss_stomp() -> void:
	camera.set_camera_shake(.25)

func _on_boss_slam(direction: int) -> void:
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
