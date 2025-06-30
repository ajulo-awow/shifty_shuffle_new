extends Node2D
#
var player_deck = ["number_card", "number_card", "number_card", "number_card", "add_card", "sub_card"]
var card_database_ref = preload("res://scripts/managers/card_database.gd").new()
var drawn_card_this_turn: bool = false
@onready var card_manager_ref: Node2D = $"../card_manager"
@onready var player_hand_ref: Node2D = $"../player_hand"
# consts
const CARD_SCENE_PATH = "res://scenes/objects/card.tscn"
const CARD_DRAW_SPEED = 0.2
const STARTING_HAND_SIZE = 5


func _ready() -> void:
	#
	player_deck.shuffle()
	#
	for i in range(STARTING_HAND_SIZE):
		draw_card()
		drawn_card_this_turn = false
	drawn_card_this_turn = true


func draw_card():
	#
	if drawn_card_this_turn:
		return
	drawn_card_this_turn = true	
	#
	var card_drawn_name = player_deck[0]
	player_deck.erase(card_drawn_name)
	#
	if player_deck.size() == 0:
		#$Area2D/CollisionShape2D.disabled = true
		#$Sprite2D.visible = false
		pass
	
	#
	var card_scene = preload(CARD_SCENE_PATH)
	var new_card = card_scene.instantiate()
	# card points
	new_card.card_points = card_database_ref.CARDS[card_drawn_name][1]
	# number display
	new_card.get_node("number_number").text = str(card_database_ref.CARDS[card_drawn_name][0])
	new_card.get_node("special_number").text = str(card_database_ref.CARDS[card_drawn_name][1])
	# weighted rng
	var weighted_rng = randf()
	#print(random)
	# likelihood of being instantiated into hand
	# 70%, number card
	if weighted_rng < 0.7:
		# card type
		new_card.card_type = "type_number"
		if new_card.card_type == "type_number":
			# number label visibility
			new_card.get_node("number_number").visible = true
			new_card.get_node("special_number").visible = false
			# image texture
			new_card.get_node("card_image").texture = load("res://sprites/objects/player_cards/number_card.png")
	# 15%, add card
	elif weighted_rng < 0.85:
		new_card.card_type = "type_add"
		if new_card.card_type == "type_add":
			new_card.get_node("number_number").visible = false
			new_card.get_node("special_number").visible = true
			new_card.get_node("card_image").texture = load("res://sprites/objects/player_cards/special_cards/add_card_special.png")
	# 15%, sub card
	else:
		new_card.card_type = "type_sub"
		if new_card.card_type == "type_sub":
			new_card.get_node("number_number").visible = false
			new_card.get_node("special_number").visible = true
			new_card.get_node("card_image").texture = load("res://sprites/objects/player_cards/special_cards/sub_card_special.png")
	card_manager_ref.add_child(new_card)
	new_card.name = "card"
	new_card.get_node("AnimationPlayer").play("card_flip")
	player_hand_ref.add_card_to_hand(new_card, CARD_DRAW_SPEED)
	#
	
	
func reset_draw():
	drawn_card_this_turn = false
	
