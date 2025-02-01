extends Control

@onready var mute = $MuteOn
@onready var easy = $SelectedEasy
@onready var medium = $SelectedMedium
@onready var hard = $SelectedHard

func _process(_delta: float) -> void:
	mute.visible = Globals.settings["mute"]
	easy.visible = Globals.settings["difficulty"] == "easy"
	medium.visible = Globals.settings["difficulty"] == "medium"
	hard.visible = Globals.settings["difficulty"] == "hard"

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		hide()

func _on_mute_pressed() -> void:
	print("muting")
	Globals.settings["mute"] = !Globals.settings["mute"]

func _on_easy_pressed() -> void:
	print("setting difficulty to easy")
	Globals.settings["difficulty"] = "easy"

func _on_medium_pressed() -> void:
	print("setting difficulty to medium")
	Globals.settings["difficulty"] = "medium"

func _on_hard_pressed() -> void:
	print("setting difficulty to hard")
	Globals.settings["difficulty"] = "hard"
