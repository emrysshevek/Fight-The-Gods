class_name Entity
extends CharacterBody2D

@export var max_speed := 300.0
@export var ground_acceleration := 1000.0
@export var ground_friction := 800.0

@export var jump_velocity := 800.0
@export var max_fall_speed := 1000.0
@export var air_acceleration := 800.0
@export var air_friction := 200.0

const MOVE_SNAP = 2.0

var grounded = false
var flipped = false

@onready var gravity: Vector2 = get_gravity()

func _physics_process(delta: float) -> void:
	move_and_slide()