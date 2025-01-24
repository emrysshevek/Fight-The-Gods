class_name PlayerState
extends State

const IDLE := "Idle"
const WALK := "Walk"
const DASH := "Dash"
const JUMP := "Jump"
const CROUCH := "Crouch"
const LAND := "Land"
const FLOAT := "Float"
const ATTACK := "Attack"
const HIT := "Hit"


var player: Player

func _ready() -> void:
	await owner.ready
	player = owner
	assert(player != null, "Player state must be used in player node")


