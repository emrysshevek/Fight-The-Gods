extends Control

signal closed()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = false
		close()

func close() -> void:
	get_tree().paused = false
	hide()
	$Continue.hide()
	$Restart.hide()
	$Options.hide()
	$Quit.hide()
	closed.emit()

func open() -> void:
	get_tree().paused = true
	show()

func _on_background_button_pressed() -> void:
	get_tree().paused = false
	close()


func _on_continue_button_pressed() -> void:
	get_tree().paused = false
	close()


func _on_continue_button_mouse_entered() -> void:
	$Continue.show()


func _on_continue_button_mouse_exited() -> void:
	$Continue.hide()


func _on_restart_button_pressed() -> void:
	close()
	get_tree().change_scene_to_file("res://scenes/boss2_battle/boss2_battle.tscn")


func _on_restart_button_mouse_entered() -> void:
	$Restart.show()


func _on_restart_button_mouse_exited() -> void:
	$Restart.hide()


func _on_options_button_pressed() -> void:
	$OptionsMenu.show()


func _on_options_button_mouse_entered() -> void:
	$Options.show()


func _on_options_button_mouse_exited() -> void:
	$Options.hide()


func _on_quit_button_pressed() -> void:
	get_tree().paused = false
	close()
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")


func _on_quit_button_mouse_entered() -> void:
	$Quit.show()


func _on_quit_button_mouse_exited() -> void:
	$Quit.hide()
