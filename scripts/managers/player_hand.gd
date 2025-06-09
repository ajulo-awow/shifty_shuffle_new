extends Node2D
# consts
const CARD_WIDTH = 60
const HAND_POS_X = 195
const HAND_POS_Y = 524
const DEFAULT_CARD_MOVE_SPEED = 0.1
# 
var player_hand = []


func _ready() -> void:
	pass

		
func add_card_to_hand(card, speed):
	card.scale = Vector2(1, 1)
	if card not in player_hand:
		player_hand.insert(0, card)
		update_hand_pos()
	else:
		animate_card_to_pos(card, card.hand_pos, DEFAULT_CARD_MOVE_SPEED)


func update_hand_pos():
	for i in range(player_hand.size()):
		var new_pos = Vector2(calculate_card_pos(i), HAND_POS_Y)
		var card = player_hand[i]
		card.hand_pos = new_pos
		animate_card_to_pos(card, new_pos, DEFAULT_CARD_MOVE_SPEED)
		

func calculate_card_pos(index):
	var x_offset = (player_hand.size() - 1) + CARD_WIDTH
	var x_pos = HAND_POS_X + index * CARD_WIDTH - x_offset / 2
	return x_pos


func animate_card_to_pos(card, new_pos, speed):
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", new_pos, speed)


func remove_card_from_hand(card):
	if card in player_hand:
		player_hand.erase(card)
		update_hand_pos()
