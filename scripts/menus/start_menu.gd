extends Control


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/managers/game_manager.tscn")
	

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/settings_menu.tscn")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/credits_menu.tscn")
