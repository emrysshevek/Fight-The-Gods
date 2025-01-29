class_name Player
extends Entity

@export var dash_speed := 1000.0

var moveable: bool = true

@onready var i_timer: Timer = $InvincibilityTimer

func _physics_process(delta: float) -> void:
	if moveable:
		handle_player_movement(delta)
	super._physics_process(delta)

	if (
		not flipped and Input.is_action_just_pressed("left")
		or flipped and Input.is_action_just_pressed("right")
	):
		flip()

func handle_player_movement(delta: float) -> void:
	moving = true
	var direction := Input.get_axis("left", "right")
	if direction == 0.0:
		moving = false

	if moving:
		if not is_on_floor():
			velocity.x = move_toward(velocity.x, direction * max_speed, air_acceleration * delta)
		else:
			velocity.x = move_toward(velocity.x, direction * max_speed, ground_acceleration * MOVE_SNAP * delta)

func flip() -> void:
	transform *= Transform2D.FLIP_X;
	flipped = !flipped

func take_damage(damage: float, _type=null) -> float:
	print("Player taking damage: ", damage, ". remaining health: ", health)
	damage = super.take_damage(1)
	if damage > 0:
		start_hit_cooldown()
	return damage

func start_hit_cooldown() -> void:
	damageable = false
	sprite.start_flash()
	i_timer.start()

func _on_invincibility_timer_timeout() -> void:
	damageable = true
	sprite.end_flash()
