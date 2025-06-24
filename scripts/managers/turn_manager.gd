extends Node
#
@onready var turn_timer: Timer = $"../turn_timer"
@onready var opp_slot: Node2D = $"../opp_card_slots/opp_slot"
@onready var opp_slot_2: Node2D = $"../opp_card_slots/opp_slot2"
@onready var opp_slot_3: Node2D = $"../opp_card_slots/opp_slot3"
@onready var end_turn_button: Button = $"../UI/end_turn"
@onready var opp_deck_ref: Node2D = $"../opp_deck"
@onready var opp_hand_ref: Node2D = $"../opp_hand"
@onready var player_deck_ref: Node2D = $"../player_deck"

#
var empty_special_card_slot = []
#
const CARD_MOVE_SPEED = 0.1

func _ready() -> void:
	turn_timer.one_shot = true
	turn_timer.wait_time = 1
	#
	empty_special_card_slot.append(opp_slot)
	empty_special_card_slot.append(opp_slot_2)
	empty_special_card_slot.append(opp_slot_3)
	
	
	
func _on_end_turn_pressed() -> void:
	opp_turn()
	
	
func opp_turn():
	
	#
	end_turn_button.disabled = true
	end_turn_button.visible = false
	#
	turn_timer.start()
	await turn_timer.timeout
	#
	if opp_deck_ref.opp_deck.size() != 0:
		opp_deck_ref.draw_card()
		turn_timer.start()
		await turn_timer.timeout
	# check if free special card slots, end turn if no
	if empty_special_card_slot.size() == 0:
		end_opp_turn()
		return
	#
	play_card_highest_points()
	
	
func play_card_highest_points():
	# get random empty slot to play card in
	if opp_hand_ref.opp_hand.size() == 0:
		end_opp_turn()
		return
	var random_empty_special_card_slot = empty_special_card_slot[randi_range(0, empty_special_card_slot.size()) - 1]
	empty_special_card_slot.erase(random_empty_special_card_slot)
	# play the card in hard with highest points
	var card_with_highest_points = opp_hand_ref.opp_hand[0]
	for card in opp_hand_ref.opp_hand:
		if card.opp_points > card_with_highest_points.opp_points:
			card_with_highest_points = card
	#
	var tween_pos = get_tree().create_tween()
	tween_pos.tween_property(card_with_highest_points, "position", random_empty_special_card_slot.position, CARD_MOVE_SPEED)
	card_with_highest_points.get_node("AnimationPlayer").play("card_flip")
	#
	opp_hand_ref.remove_card_from_hand(card_with_highest_points)
	#
	end_opp_turn()
	
	
func end_opp_turn():
	end_turn_button.disabled = false
	end_turn_button.visible = true
	#
	player_deck_ref.reset_draw()
	#$"../card_manager".reset_played_special_card()
	
	
