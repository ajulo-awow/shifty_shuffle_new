extends Node2D
#
var player_deck = ["number_card", "number_card", "add_card", "sub_card", "swap_card"]
var card_database_ref
# consts
const CARD_SCENE_PATH = "res://scenes/objects/card.tscn"
const CARD_DRAW_SPEED = 0.2


func _ready() -> void:
	#
	card_database_ref = preload("res://scripts/managers/card_database.gd").new()
	#

func draw_card():
	var card_drawn_name = player_deck[0]
	player_deck.erase(card_drawn_name)
	#
	if player_deck.size() == 0:
		$Area2D/CollisionShape2D.disabled = true
		$Sprite2D.visible = false
	#
	var card_scene = preload(CARD_SCENE_PATH)
	var new_card = card_scene.instantiate()
	# 
	#var number_card_value = card_database_ref.CARDS["number_card"][0]
	# number display
	new_card.get_node("number_number").text = str(card_database_ref.CARDS[card_drawn_name][0])
	print(new_card.get_node("number_number").text)
	new_card.get_node("special_number").text = str(card_database_ref.CARDS[card_drawn_name][1])
	# weighted rng
	var random = randf()
	print(random)
	# likelihood of being instantiated into hand
	# 60%, number card
	if random < 0.6:
		#print("is number card")
		# number label visibility
		new_card.get_node("number_number").visible = true
		new_card.get_node("special_number").visible = false
		# number value
		#number_card_value = randi_range(1, 10)
		# image texture
		new_card.get_node("card_image").texture = load("res://sprites/objects/player_cards/number_card.png")
	# 15%, add card
	elif random < 0.75:
		#print("is add card")
		new_card.get_node("number_number").visible = false
		new_card.get_node("special_number").visible = true
		new_card.get_node("card_image").texture = load("res://sprites/objects/player_cards/special_cards/add_card_special.png")
	# 15%, sub card
	elif random < 0.9:
		#print("is sub card")
		new_card.get_node("number_number").visible = false
		new_card.get_node("special_number").visible = true
		new_card.get_node("card_image").texture = load("res://sprites/objects/player_cards/special_cards/sub_card_special.png")
	# 10%, swap card
	else:
		#print("is swap card")
		new_card.get_node("number_number").visible = false
		new_card.get_node("special_number").visible = true
		new_card.get_node("card_image").texture = load("res://sprites/objects/player_cards/special_cards/swap_card_special.png")
	# display
	#if card_database_ref.CARDS[card_drawn_name] == card_database_ref.CARDS["number_card"]:
		#new_card.get_node("number_number").visible = true
		#new_card.get_node("special_number").visible = false
		##
		#new_card.get_node("card_image").texture = load("res://sprites/objects/player_cards/number_card.png")
	##
	#if card_database_ref.CARDS[card_drawn_name] == card_database_ref.CARDS["add_card"] or card_database_ref.CARDS[card_drawn_name] == card_database_ref.CARDS["sub_card"] or card_database_ref.CARDS[card_drawn_name] == card_database_ref.CARDS["swap_card"]:
		#new_card.get_node("number_number").visible = false
		#new_card.get_node("special_number").visible = true
		##
		#new_card.get_node("card_image").texture = load(special_card_image_path)
	#
	$"../card_manager".add_child(new_card)
	new_card.name = "card"
	$"../player_hand".add_card_to_hand(new_card, CARD_DRAW_SPEED)
