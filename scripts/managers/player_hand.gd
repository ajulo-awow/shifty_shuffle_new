extends Node2D
# consts
const HAND_COUNT = 5
const CARD_WIDTH = 60
const HAND_POS_X = 195
const HAND_POS_Y = 524
const CARD_SCENE_PATH = "res://scenes/objects/card.tscn"
# 
var player_hand = []


func _ready() -> void:
	var card_scene = preload(CARD_SCENE_PATH)
	#
	for i in range(HAND_COUNT):
		var new_card = card_scene.instantiate()
		$"../card_manager".add_child(new_card)
		new_card.name = "card"
		add_card_to_hand(new_card)

		
func add_card_to_hand(card):
	if card not in player_hand:
		player_hand.insert(0, card)
		update_hand_pos()
	else:
		animate_card_to_pos(card, card.hand_pos)


func update_hand_pos():
	for i in range(player_hand.size()):
		var new_pos = Vector2(calculate_card_pos(i), HAND_POS_Y)
		var card = player_hand[i]
		card.hand_pos = new_pos
		animate_card_to_pos(card, new_pos)
		

func calculate_card_pos(index):
	var x_offset = (player_hand.size() - 1) + CARD_WIDTH
	var x_pos = HAND_POS_X + index * CARD_WIDTH - x_offset / 2
	return x_pos


func animate_card_to_pos(card, new_pos):
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", new_pos, 0.1)


func remove_card_from_hand(card):
	if card in player_hand:
		player_hand.erase(card)
		update_hand_pos()
