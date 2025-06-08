extends Node2D
#
var player_deck = ["card1", "card2", "card3", "car4", "card5"]
#
const CARD_SCENE_PATH = "res://scenes/objects/card.tscn"
const CARD_DRAW_SPEED = 0.2


func _ready() -> void:
	pass


func draw_card():
	var card_drawn = player_deck[0]
	player_deck.erase(card_drawn)
	# 
	if player_deck.size() == 0:
		$Area2D/CollisionShape2D.disabled = true
	#
	var card_scene = preload(CARD_SCENE_PATH)
	var new_card = card_scene.instantiate()
	$"../card_manager".add_child(new_card)
	new_card.name = "card"
	$"../player_hand".add_card_to_hand(new_card, CARD_DRAW_SPEED)
