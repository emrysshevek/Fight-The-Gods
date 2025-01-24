class_name Entity
extends CharacterBody2D

signal hit(which_entity: Entity)
signal damaged(which_entity: Entity)
signal died(which_entity: Entity)

@export var max_speed := 300.0
@export var ground_acceleration := 1000.0
@export var ground_friction := 800.0

@export var jump_velocity := 800.0
@export var max_fall_speed := 1000.0
@export var air_acceleration := 800.0
@export var air_friction := 200.0

@export var max_health := 100.0
@export var i_duration := .25

const MOVE_SNAP = 2.0

var grounded = false
var moving = false
var flipped = false
var damageable = true

@onready var gravity: Vector2 = get_gravity()
@onready var health := max_health

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ap: AnimationPlayer = $AnimationPlayer

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y = move_toward(velocity.y, max_fall_speed, gravity.y * delta)
		if not moving:
			velocity.x = move_toward(velocity.x, 0, air_friction * delta)
	elif not moving:
		velocity.x = move_toward(velocity.x, 0, ground_friction * MOVE_SNAP * delta)

	move_and_slide()

func try_hit() -> bool:
	if damageable:
		return true
	return false

func take_damage(damage: float, _type=null) -> void:
	if damage <= 0:
		return
	
	health -= damage
	damaged.emit(self)

	if health <= 0:
		health = 0
		die()

func die() -> void:
	died.emit(self)
	queue_free()

func _on_hurtbox_hit(_which_hurtbox:Hurtbox, which_hitbox:Hitbox) -> void:\
	if damageable:
		hit.emit(self, which_hitbox.entity)



