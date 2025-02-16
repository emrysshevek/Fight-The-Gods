extends Control

func _on_retry_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/boss2_battle/boss2_battle.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")


func _on_retry_button_mouse_entered() -> void:
	$HBoxContainer/RetryButton/RetrySelected.show()


func _on_retry_button_mouse_exited() -> void:
	$HBoxContainer/RetryButton/RetrySelected.hide()


func _on_quit_button_mouse_entered() -> void:
	$HBoxContainer/QuitButton/QuitSelected.show()


func _on_quit_button_mouse_exited() -> void:
	$HBoxContainer/QuitButton/QuitSelected.hide()
