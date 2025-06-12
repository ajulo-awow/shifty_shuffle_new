extends Node2D
#
var opp_deck = ["number_card", "number_card", "number_card", "number_card", "add_card", "sub_card"]
var card_database_ref
# consts
const CARD_SCENE_PATH = "res://scenes/objects/opp_card.tscn"
const CARD_DRAW_SPEED = 0.2
const STARTING_HAND_SIZE = 5


func _ready() -> void:
	#
	card_database_ref = preload("res://scripts/managers/card_database.gd").new()
	#
	opp_deck.shuffle()
	#
	for i in range(STARTING_HAND_SIZE):
		draw_card()
	


func draw_card():
	if opp_deck.size() == 0:
		return
	#
	var card_drawn_name = opp_deck[0]
	opp_deck.erase(card_drawn_name)
	#
	if opp_deck.size() == 0:
		#$Area2D/CollisionShape2D.disabled = true
		$Sprite2D.visible = false
		pass
	#
	var card_scene = preload(CARD_SCENE_PATH)
	var new_card = card_scene.instantiate()
	# 
	#var number_card_value = card_database_ref.CARDS["number_card"][0]
	#
	new_card.opp_points = card_database_ref.CARDS[card_drawn_name][1]
	new_card.get_node("number_number").text = str(card_database_ref.CARDS[card_drawn_name][0])
	new_card.get_node("special_number").text = str(new_card.opp_points)
	# card type
	new_card.card_type = card_database_ref.CARDS[card_drawn_name][2]
	# weighted rng
	var random = randf()
	#print(random)
	# likelihood of being instantiated into hand
	# 70%, number card
	if random < 0.8:
		#print("is number card")
		# number label visibility
		new_card.get_node("number_number").visible = true
		new_card.get_node("special_number").visible = false
		# image texture
		new_card.get_node("card_image").texture = load("res://sprites/objects/opp_cards/opp_number_card.png")
	# 15%, add card
	elif random < 0.9:
		#print("is add card")
		new_card.get_node("number_number").visible = false
		new_card.get_node("special_number").visible = true
		new_card.get_node("card_image").texture = load("res://sprites/objects/opp_cards/opp_add_card.png")
	# 15%, sub card
	else:
		#print("is sub card")
		new_card.get_node("number_number").visible = false
		new_card.get_node("special_number").visible = true
		new_card.get_node("card_image").texture = load("res://sprites/objects/opp_cards/opp_sub_card.png")
	# 10%, swap card
	#else:
		#print("is swap card")
		#new_card.get_node("number_number").visible = false
		#new_card.get_node("special_number").visible = true
		#new_card.get_node("card_image").texture = load("res://sprites/objects/player_cards/special_cards/swap_card_special.png")
	$"../card_manager".add_child(new_card)
	new_card.name = "card"
	$"../opp_hand".add_card_to_hand(new_card, CARD_DRAW_SPEED)
