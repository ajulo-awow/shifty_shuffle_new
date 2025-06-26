class_name PointsManager
extends Node
#
var player_points: int = 0
var opp_points: int = 0
@onready var player_points_label: Label = $"../UI/player_points"
@onready var opp_points_label: Label = $"../UI/opp_points"


func _process(delta: float) -> void:
	player_points_label.text = str(player_points)
	opp_points_label.text = str(opp_points)
