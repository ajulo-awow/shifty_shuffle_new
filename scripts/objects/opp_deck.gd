extends Node2D
#
var opp_deck = ["number_card", "number_card", "number_card", "number_card", "add_card", "sub_card"]
var card_database_ref = preload("res://scripts/managers/card_database.gd").new()
@onready var opp_deck_sprite: Sprite2D = $opp_deck_sprite
@onready var card_manager_ref: Node2D = $"../card_manager"
@onready var opp_hand_ref: Node2D = $"../opp_hand"

# consts
const CARD_SCENE_PATH = "res://scenes/objects/opp_card.tscn"
const CARD_DRAW_SPEED = 0.2
const STARTING_HAND_SIZE = 5


func _ready() -> void:
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
		opp_deck_sprite.visible = false
		pass
	#
	var card_scene = preload(CARD_SCENE_PATH)
	var new_card = card_scene.instantiate()
	#
	new_card.card_points = card_database_ref.CARDS[card_drawn_name][1]
	#
	new_card.get_node("number_number").text = str(card_database_ref.CARDS[card_drawn_name][0])
	new_card.get_node("special_number").text = str(new_card.card_points)
	# weighted rng
	var random = randf()
	# likelihood of being instantiated into hand
	# 85%, number card
	if random < 0.85:
		# card type
		new_card.card_type = "type_number"
		if new_card.card_type == "type_number":
			# number label visibility
			new_card.get_node("number_number").visible = true
			new_card.get_node("special_number").visible = false
			# image texture
			new_card.get_node("card_image").texture = load("res://sprites/objects/opp_cards/opp_number_card.png")
	# 10%, add card
	elif random < 0.95:
		new_card.card_type = "type_add"
		if new_card.card_type == "type_add":
			new_card.get_node("number_number").visible = false
			new_card.get_node("special_number").visible = true
			new_card.get_node("card_image").texture = load("res://sprites/objects/opp_cards/opp_add_card.png")
	# 5%, sub card
	else:
		new_card.card_type = "type_sub"
		if new_card.card_type == "type_sub":
			new_card.get_node("number_number").visible = false
			new_card.get_node("special_number").visible = true
			new_card.get_node("card_image").texture = load("res://sprites/objects/opp_cards/opp_sub_card.png")
	# 10%, swap card
	#else:
		#print("is swap card")
		#new_card.get_node("number_number").visible = false
		#new_card.get_node("special_number").visible = true
		#new_card.get_node("card_image").texture = load("res://sprites/objects/player_cards/special_cards/swap_card_special.png")
	card_manager_ref.add_child(new_card)
	opp_hand_ref.add_card_to_hand(new_card, CARD_DRAW_SPEED)
