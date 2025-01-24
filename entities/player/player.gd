class_name Player
extends Entity

@export var dash_speed := 1000.0

@onready var i_timer: Timer = $InvincibilityTimer

func _physics_process(delta: float) -> void:
	super._physics_process(delta)

	if (
		not flipped and Input.is_action_just_pressed("left")
		or flipped and Input.is_action_just_pressed("right")
	):
		flip()

func flip() -> void:
	transform *= Transform2D.FLIP_X;
	flipped = !flipped

func take_damage(damage: float, _type=null) -> void:
	print("Player taking damage: ", damage, ". remaining health: ", health)
	if damage > 0:
		start_hit_cooldown()
		super.take_damage(1)

func start_hit_cooldown() -> void:
	damageable = false
	sprite.start_flash()
	i_timer.start()

func _on_invincibility_timer_timeout() -> void:
	damageable = true
	sprite.end_flash()
