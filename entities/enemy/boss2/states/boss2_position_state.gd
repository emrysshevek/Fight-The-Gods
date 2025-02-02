class_name Boss2PositionState
extends Boss2State

var direction := 1
var elapsed := 0.0

@onready var timer: Timer = Timer.new()

func _ready() -> void:
	super._ready()
	timer.wait_time = 2
	timer.one_shot = true
	add_child(timer)

func enter(_previous_state_path: String, _data := {}) -> void:
	boss.ap.play("walk")
	boss.ap.speed_scale = .5

	direction = [-1, 1].pick_random()
	if (direction == -1 and not boss.flipped) or (direction == 1 and boss.flipped):
		boss.flip()
		
	elapsed = 0

func exit() -> void:
	boss.ap.speed_scale = 1

func physics_update(delta: float) -> void:
	elapsed += delta

	print(boss.velocity)
	if elapsed > 2 and boss.velocity.x == 0:
		print("boss reached target")
		boss.flip()
		finished.emit(THROW)
		return

	boss.velocity.x = move_toward(boss.velocity.x, direction * boss.max_speed, boss.ground_acceleration * boss.MOVE_SNAP * delta)
