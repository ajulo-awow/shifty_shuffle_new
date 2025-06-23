extends Control
#
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var start_button: TextureButton = $start
@onready var settings_button: TextureButton = $settings
@onready var credits_button: TextureButton = $credits


func _ready() -> void:
	anim_player.play("start_menu_title_anim")
	#
	start_button.pivot_offset = start_button.size/2
	settings_button.pivot_offset = settings_button.size/2
	credits_button.pivot_offset = credits_button.size/2


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/managers/game_manager.tscn")
	

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/settings_menu.tscn")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/credits_menu.tscn")


func _on_start_mouse_entered() -> void:
	start_button.scale = Vector2(1.6, 1.6)
func _on_start_mouse_exited() -> void:
	start_button.scale = Vector2(1.5, 1.5)


func _on_settings_mouse_entered() -> void:
	settings_button.scale = Vector2(1.6, 1.6)
func _on_settings_mouse_exited() -> void:
	settings_button.scale = Vector2(1.5, 1.5)
	

func _on_credits_mouse_entered() -> void:
	credits_button.scale = Vector2(1.6, 1.6)
func _on_credits_mouse_exited() -> void:
	credits_button.scale = Vector2(1.5, 1.5)
