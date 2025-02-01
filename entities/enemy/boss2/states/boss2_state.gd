class_name Boss2State
extends EntityState

const IDLE := "Idle"
const CHASE := "Chase"
const POSIITON := "Position"
const THROW := "Throw"
const SLAM := "Slam"
const SPIN := "Spin"

var boss: Boss2

func _ready() -> void:
	await owner.ready
	boss = owner as Boss2
	assert(boss != null, "boss2 state must be used in boss2 node")
