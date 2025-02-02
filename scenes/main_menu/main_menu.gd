extends Node2D

@onready var theme = preload("res://assets/music/Main Menu/MainMenu_Mix-07_Final.wav")
@onready var loop = preload("res://assets/music/Main Menu/MainMenu_Loop-07_Final.wav")

func _ready() -> void:
	AudioMixer.play(theme, loop)
	Engine.time_scale = 1

func _on_play_button_pressed() -> void:
	$AnimationPlayer.play("transition")
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)
	

func _on_options_button_pressed() -> void:
	$UI/Control/Options.show()

func _on_credits_button_pressed() -> void:
	$UI/Control/Credits.show()

func _on_bonus_button_pressed() -> void:
	pass # Replace with function body.

func _on_bonus_button_mouse_exited() -> void:
	pass # Replace with function body.

func _on_bonus_button_mouse_entered() -> void:
	pass # Replace with function body.

func _on_animation_finished(name: StringName) -> void:
	if name == "transition":
		get_tree().change_scene_to_file("res://scenes/boss2_battle/boss2_battle.tscn")
