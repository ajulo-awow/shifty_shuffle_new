extends Control


func _on_back_arrow_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/start_menu.tscn")


func _on_master_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0, toggled_on)


func _on_music_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(1, toggled_on)


func _on_sfx_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(2, toggled_on)


func _on_mouse_sensitivity_bar_value_changed(value: float) -> void:
	pass # Replace with function body.
