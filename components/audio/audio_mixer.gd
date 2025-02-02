extends Node2D

@onready var player1: AudioStreamPlayer = $Player1

func _ready() -> void:
	mute(Globals.settings["mute"])

func play(track: AudioStream, loop: AudioStream = null) -> void:
	player1.stop()

	player1.stream = track
	player1.play()

	if loop:
		player1.finished.connect(func(): play(loop))

func mute(toggled:=true) -> void:
	Globals.settings["mute"] = toggled
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), toggled)
