class_name Boss2ThrowState
extends Boss2State

@export var duration := 4.0
@export var speed := 300.0
@export var max_throws := 5

var target: Vector2
var throws := 0

func enter(_previous_state_path: String, _data := {}) -> void:
    throws = 0
    boss.ap.play("idle")
    get_tree().create_timer(3 * (1 + Globals.difficulty_multiplier)).timeout.connect(_initiate)

func _initiate() -> void:
    get_tree().create_timer(.475).timeout.connect(_throw)
    target = get_tree().get_first_node_in_group("player").global_position
    var dir = target.x - boss.global_position.x
    if dir < 0 and not boss.flipped:
        boss.flip()
    elif dir > 0 and boss.flipped:
        boss.flip()

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

    throws += 1
    if throws == max_throws:
        finished.emit(SLAM)
        return

    boss.ap.play("idle")
    get_tree().create_timer(3 * (1 + Globals.difficulty_multiplier)).timeout.connect(_initiate)

