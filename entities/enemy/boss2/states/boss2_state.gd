class_name Boss2State
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

var boss: Boss2

func _ready() -> void:
	await owner.ready
	boss = owner as Boss2
	assert(boss != null, "boss2 state must be used in boss2 node")