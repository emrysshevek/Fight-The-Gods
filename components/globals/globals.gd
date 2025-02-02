extends Node

signal spin_started()
signal spin_ended()

@export var game_won := false
@export var settings: Dictionary = {
	"mute": false,
	"difficulty": "hard"
}

var spinning = false

func _ready() -> void:
	var game_status = load_from_file()
	if game_status != null and game_status == "won":
		game_won = true
	print(game_won)

func start_spin() -> void:
	spinning = true
	spin_started.emit()

func end_spin() -> void:
	spinning = false
	spin_ended.emit()

func beat_game() -> void:
	game_won = true
	save_to_file("won")

func save_to_file(content):
	var file = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	file.store_string(content)

func load_from_file():
	var file = FileAccess.open("user://save_game.dat", FileAccess.READ)
	if file == null:
		print(error_string(FileAccess.get_open_error()))
		return 
		
	var content = file.get_as_text()
	return content