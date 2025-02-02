extends Node

signal spin_started()
signal spin_ended()

@export var game_won := false
@export var settings: Dictionary = {
	"mute": false,
	"difficulty": "medium"
}

var spinning = false
var difficulty_multiplier := 0.0


func set_difficulty(difficulty: String) -> void:
	match difficulty:
		"easy":
			difficulty_multiplier = .5
		"medium":
			difficulty_multiplier = 0
		"hard":
			difficulty_multiplier = -.5
	settings["difficulty"] = difficulty

func start_spin() -> void:
	spinning = true
	spin_started.emit()

func end_spin() -> void:
	spinning = false
	spin_ended.emit()

func beat_game() -> void:
	game_won = true
