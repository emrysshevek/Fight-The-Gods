class_name ProjectileAttack
extends Attack

@export var start_position: Vector2
@export var target_position: Vector2
@export var destination_position: Vector2

@export var speed := 300
@export var duration := 4.0

var direction: Vector2 
var elapsed := 0.0

func _ready() -> void:
	hide()

func throw(start: Vector2, target: Vector2, dest: Vector2, duration:=-1.0, speed:=-1) -> void:
	start_position = start
	target_position = target
	destination_position = dest

	if duration > 0:
		self.duration = duration
	if speed > 0:
		self.speed = speed

	self.start()

func start() -> void:
	super.start()
	global_position = start_position
	direction = global_position.direction_to(target_position).normalized()
	get_tree().create_timer(duration/2).timeout.connect(_on_halfway_timer_timeout)
	show()

func end() -> void:
	super.end()
	hide()

func _physics_process(delta: float) -> void:
	if not active:
		return		

	global_position += direction * speed * delta

func _on_halfway_timer_timeout() -> void:
	direction = global_position.direction_to(destination_position).normalized()
	already_hit = []
	get_tree().create_timer(duration/2).timeout.connect(end)
