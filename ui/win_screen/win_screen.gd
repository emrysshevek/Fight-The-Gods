extends Control


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/boss2_battle/boss2_battle.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")


func _on_retry_mouse_entered() -> void:
	$HBoxContainer/Retry/RetrySelected.show()


func _on_retry_mouse_exited() -> void:
	$HBoxContainer/Retry/RetrySelected.hide()


func _on_main_menu_mouse_entered() -> void:
	$HBoxContainer/MainMenu/QuitSelected.show()


func _on_main_menu_mouse_exited() -> void:
	$HBoxContainer/MainMenu/QuitSelected.hide()
