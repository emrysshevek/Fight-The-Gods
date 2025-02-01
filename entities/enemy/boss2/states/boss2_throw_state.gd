class_name Boss2ThrowState
extends Boss2State

@export var duration := 4.0
@export var speed := 300.0

var target: Vector2

func enter(_previous_state_path: String, _data := {}) -> void:
    get_tree().create_timer(.475).timeout.connect(_throw)
    target = get_tree().get_first_node_in_group("player").global_position
    target.y -= 50
    boss.ap.play("throw")

func _throw() -> void:
    var start: Vector2 = boss.get_node("Markers/ThrowStart").global_position
    var end: Vector2 = boss.get_node("Markers/ThrowEnd").global_position
    
    boss.get_node("ProjectileAttack").throw(start, target, end, duration, speed)
    get_tree().create_timer(duration - .375).timeout.connect(_catch)

func _catch() -> void:
    boss.ap.play("catch")
    boss.ap.animation_finished.connect(_on_caught)

func _on_caught(_name: StringName) -> void:
    boss.ap.animation_finished.disconnect(_on_caught)
    finished.emit(IDLE)
