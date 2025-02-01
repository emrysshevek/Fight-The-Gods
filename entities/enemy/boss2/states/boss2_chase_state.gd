class_name Boss2ChaseState
extends Boss2State

@export var walK_max_duration := 2.0
@export var total_duration := 10.0

var walking := true
var elapsed := 0.0

@onready var timer: Timer = Timer.new()

func _ready() -> void:
    super._ready()
    timer.wait_time = 2
    timer.one_shot = true
    add_child(timer)

func enter(_previous_state_path: String, _data := {}) -> void:
    walking = true
    boss.ap.play("walk")
    boss.ap.animation_changed.connect(_on_animation_changed)
    timer.timeout.connect(_switch_action)
    elapsed = 0

func exit() -> void:
    boss.ap.animation_changed.disconnect(_on_animation_changed)
    timer.timeout.disconnect(_switch_action)

func physics_update(delta: float) -> void:
    elapsed += delta

    var player = get_tree().get_first_node_in_group("player")

    if walking:
        timer.stop()
        
        if abs(boss.global_position.x - player.global_position.x) < 50:
            _switch_action()
            return

        var direction = sign(boss.global_position.direction_to(player.global_position).x)
        boss.velocity.x = move_toward(boss.velocity.x, boss.max_speed * direction, boss.ground_acceleration)

        direction = sign(boss.velocity.x)
        if (direction == -1 and not boss.flipped) or (direction == 1 and boss.flipped):
            boss.flip()

func _switch_action() -> void:
    if not walking:
        walking = true
        boss.ap.play("walk")
        boss.ap.speed_scale = .5
        timer.start()
    else:
        walking = false
        boss.ap.play("idle")
        boss.ap.speed_scale = 1
        boss.velocity = Vector2.ZERO
        await get_tree().create_timer(.75).timeout
        boss.ap.play("simple_attack")
        boss.ap.speed_scale = 1
        var direction = sign(get_tree().get_first_node_in_group("player").global_position.x - boss.global_position.x)
        if (direction == -1 and not boss.flipped) or (direction == 1 and boss.flipped):
            boss.flip()
        for i in range(2):
            boss.ap.queue("simple_attack")
        boss.ap.queue("walk")

func _on_animation_changed(_old: StringName, new: StringName) -> void:
    if elapsed >= total_duration:
        finished.emit(POSIITON)
        return

    if new == "walk":
        _switch_action() 
