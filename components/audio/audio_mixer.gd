extends Node2D

@onready var player1: AudioStreamPlayer = $Player1

func play(track: AudioStream, loop: AudioStream = null) -> void:
	player1.stream = track
	player1.play()

	if loop:
		get_tree().create_timer(player1.stream.get_length()).timeout.connect(func(): play(loop))
