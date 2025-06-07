extends Node



func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().change_scene_to_file("res://scenes/menus/start_menu.tscn")
