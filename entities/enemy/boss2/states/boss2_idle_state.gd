class_name Boss2IdleState
extends Boss2State

@onready var timer: Timer = Timer.new()
@onready var first_round = true

func _ready() -> void:
    super._ready()
    timer.wait_time = 4 * (1 + Globals.difficulty_multiplier)
    timer.one_shot = true
    timer.timeout.connect(_on_timer_timeout)
    add_child(timer)

func enter(_previous_state_path: String, _data := {}) -> void:
    boss.ap.play("idle")
    timer.start()

func exit() -> void:
    timer.stop()

func _on_timer_timeout() -> void:
    print("idle timer finished")
    if first_round:
        finished.emit(POSIITON)
        first_round = false
    else:
        finished.emit(CHASE)