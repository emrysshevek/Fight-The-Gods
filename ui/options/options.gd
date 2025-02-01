extends Control

signal closed()

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
		closed.emit()

func _on_background_pressed() -> void:
	hide()
	closed.emit()

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


func _on_easy_button_mouse_entered() -> void:
	easy.show()


func _on_easy_button_mouse_exited() -> void:
	easy.hide()


func _on_medium_button_mouse_entered() -> void:
	medium.show()


func _on_medium_button_mouse_exited() -> void:
	medium.hide()


func _on_hard_button_mouse_entered() -> void:
	hard.show()


func _on_hard_button_mouse_exited() -> void:
	hard.hide()
