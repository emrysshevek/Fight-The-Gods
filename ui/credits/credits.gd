extends Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		hide()


func _on_background_button_pressed() -> void:
	hide()
