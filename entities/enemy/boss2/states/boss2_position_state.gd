class_name Boss2PositionState
extends Boss2State

var target: Node2D
var target_position: Vector2
var action := "walk"
var direction := 1

@onready var timer: Timer = Timer.new()

func _ready() -> void:
	super._ready()
	timer.wait_time = 2
	timer.one_shot = true
	add_child(timer)
	# target = boss.left_target

func enter(_previous_state_path: String, _data := {}) -> void:
	if target == null:
		target = boss.right_target
	else:
		var targets: Array[Node2D] = [boss.left_target, boss.right_target]
		targets.erase(target)
		target = targets.pick_random()
	target_position = target.global_position

	_switch_action()
	boss.ap.animation_changed.connect(_on_animation_changed)
	timer.timeout.connect(_on_timer_timeout)

func exit() -> void:
	boss.ap.speed_scale = 1
	boss.ap.animation_changed.disconnect(_on_animation_changed)
	timer.timeout.disconnect(_on_timer_timeout)
	timer.stop()

func physics_update(delta: float) -> void:
	if abs(boss.global_position.x - target_position.x) < 5:
		print("boss reached target")
		boss.flip()
		finished.emit(THROW)
		return

	if action == "walk":
		boss.ap.play("walk")
		boss.velocity.x = move_toward(boss.velocity.x, direction * boss.max_speed, boss.ground_acceleration * boss.MOVE_SNAP * delta)

func _switch_action() -> void:
	if action == "attack":
		action = "walk"
		boss.ap.play("walk")
		boss.ap.speed_scale = .5
		direction = sign(target_position.x - boss.global_position.x)
		if (direction == -1 and not boss.flipped) or (direction == 1 and boss.flipped):
			boss.flip()
	else:
		action = "attack"
		boss.ap.play("idle")
		boss.ap.speed_scale = 1
		await get_tree().create_timer(.75).timeout
		boss.ap.play("simple_attack")
		boss.ap.speed_scale = 1
		direction = sign(get_tree().get_first_node_in_group("player").global_position.x - boss.global_position.x)
		if (direction == -1 and not boss.flipped) or (direction == 1 and boss.flipped):
			boss.flip()
		for i in range(2):
			boss.ap.queue("simple_attack")
		boss.ap.queue("walk")

func _on_animation_changed(_old: StringName, new: StringName) -> void:
	if new == "walk":
		_switch_action() 
	else:
		direction = sign(get_tree().get_first_node_in_group("player").global_position.x - boss.global_position.x)
		if (direction == -1 and not boss.flipped) or (direction == 1 and boss.flipped):
			boss.flip()      

func _on_timer_timeout() -> void:
	_switch_action()
