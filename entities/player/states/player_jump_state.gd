class_name PlayerJumpState
extends PlayerState

var jump_duration: float
var in_jump: bool = false
var elapsed := 0.0
var holding = true

func enter(_previous_state_path: String, _data := {}) -> void:
    player.moveable = true
    player.grounded = false
    player.ap.play("jump")
    jump_duration = player.ap.current_animation_length / 2
    player.ap.animation_finished.connect(_on_animation_finished)
    player.velocity.y = -player.jump_velocity
    in_jump = true
    elapsed = 0
    holding = Input.is_action_pressed("up")

func exit() -> void:
    in_jump = false
    player.ap.animation_finished.disconnect(_on_animation_finished)

func physics_update(delta: float) -> void:
    if player.is_on_floor():
        finished.emit(LAND)
        return

    player.gravity = player.get_gravity()
    elapsed += delta
    # if elapsed < jump_duration:
    #     holding = holding and Input.is_action_pressed("up")
    #     if holding:
    #         player.gravity = player.get_gravity() / 2

    if Input.is_action_pressed("jump"):
        player.gravity =  player.get_gravity() * .5
    elif Input.is_action_pressed("crouch"):
        player.gravity = player.get_gravity() * 2
    else:
        player.gravity = player.get_gravity()
    

    handle_transition([DASH])

func _on_animation_finished(anim_name: StringName) -> void:
    assert(str(anim_name) == "jump", "Incorrect animation [" + str(anim_name) + "] playing during jump state. Expected " + "jump" )
    finished.emit(FLOAT)
