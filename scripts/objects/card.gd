extends Node2D
#
signal hovered
signal hovered_off
#
var hand_pos
var card_slot_card_in
var card_type
var card_points: int = 0
var card_database_ref


func _ready() -> void:
	get_parent().connect_card_signals(self)
	#

	
func _process(_delta: float) -> void:
	pass

	
	
func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovered", self)


func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovered_off", self)
