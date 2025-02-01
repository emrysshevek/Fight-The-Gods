extends Node

signal spin_started()
signal spin_ended()

@export var settings: Dictionary = {
	"mute": false,
	"difficulty": "hard"
}

var spinning = false


func start_spin() -> void:
	spinning = true
	spin_started.emit()

func end_spin() -> void:
	spinning = false
	spin_ended.emit()