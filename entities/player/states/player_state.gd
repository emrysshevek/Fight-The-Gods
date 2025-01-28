class_name PlayerState
extends State

const IDLE := "Idle"
const WALK := "Walk"
const DASH := "Dash"
const JUMP := "Jump"
const CROUCH := "Crouch"
const LAND := "Land"
const FLOAT := "Float"
const SIMPLE_ATTACK := "SimpleAttack"
const HEAVY_ATTACK := "HeavyAttack"
const HIT := "Hit"

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner
	assert(player != null, "Player state must be used in player node")

func handle_transition(allowed: Array[String]) -> String:
	if FLOAT in allowed and not player.is_on_floor():
		finished.emit(FLOAT)
		return FLOAT
	if not player.grounded and player.is_on_floor():
		finished.emit(LAND)
		return LAND
	elif DASH in allowed and Input.is_action_just_pressed("dash"):
		finished.emit(DASH)
		return DASH
	elif SIMPLE_ATTACK in allowed and Input.is_action_just_pressed("simple_attack"):
		finished.emit(SIMPLE_ATTACK)
		return SIMPLE_ATTACK
	elif HEAVY_ATTACK in allowed and Input.is_action_just_pressed("heavy_attack"):
		finished.emit(HEAVY_ATTACK)
		return HEAVY_ATTACK
	elif JUMP in allowed and Input.is_action_just_pressed("jump"):
		finished.emit(JUMP)
		return JUMP
	elif CROUCH in allowed and Input.is_action_pressed("crouch"):
		finished.emit(CROUCH)
		return CROUCH
	elif WALK in allowed and player.is_on_floor() and (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		finished.emit(WALK)
		return WALK
	elif IDLE in allowed:
		finished.emit(IDLE)
		return IDLE
	
	return ""