class_name Boss2SlamState
extends Boss2State

@export var pause_duration := 4.0

var max_reps := 3
var count := 0

@onready var timer := Timer.new()

func _ready() -> void:
    super._ready()
    timer.wait_time = pause_duration
    timer.one_shot = true
    add_child(timer)

func enter(_previous_state_path: String, _data := {}) -> void:
    count = 0

    timer.timeout.connect(_on_timer_timeout)
    boss.ap.animation_finished.connect(_on_animation_finished)

    boss.ap.play("idle")
    timer.start()

func exit() -> void:
    timer.timeout.disconnect(_on_timer_timeout)
    boss.ap.animation_finished.disconnect(_on_animation_finished)    

func _on_animation_finished(_name: StringName) -> void:
    boss.ap.speed_scale = 1
    finished.emit(SPIN)

func _on_timer_timeout() -> void:
    boss.ap.speed_scale = 1.25
    boss.ap.play("heavy_attack")

