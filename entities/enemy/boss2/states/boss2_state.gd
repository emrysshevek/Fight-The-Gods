class_name Boss2State
extends State

const IDLE := "Idle"
const POSIITON := "Position"
const WAVE := "Wave"

var boss: Boss2

func _ready() -> void:
	await owner.ready
	boss = owner as Boss2
	assert(boss != null, "boss2 state must be used in boss2 node")