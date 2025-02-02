class_name Boss2ThrowState
extends Boss2State

@export var duration := 4.0
@export var speed := 300.0
@export var max_throws := 3

var target: Vector2
var throws := 0

func enter(_previous_state_path: String, _data := {}) -> void:
    throws = 0
    boss.ap.play("idle")
    get_tree().create_timer(3 * (1 + Globals.difficulty_multiplier)).timeout.connect(_initiate)

func _initiate() -> void:
    get_tree().create_timer(.475).timeout.connect(_throw)
    target = get_tree().get_first_node_in_group("player").global_position
    target.y -= 50
    
    var start: Vector2 = boss.get_node("Markers/ThrowStart").global_position

    var target_dir = start.direction_to(target)
    var facing_dir = Vector2.LEFT if boss.flipped else Vector2.RIGHT
    var rotation = facing_dir.angle_to(target_dir)
    var throwing_dir = facing_dir.rotated(clamp(rotation, -PI/6, PI/6)).normalized()
    print("target: ", target, ", start: ", start, ", target_dir: ", target_dir.normalized(), ", facing_dir: ", facing_dir, ", rotation: ", rad_to_deg(rotation))
    target = start + throwing_dir * 10
    print("throwing dir: ", throwing_dir, ", new target: ", target)


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
