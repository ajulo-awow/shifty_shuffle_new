extends Node2D
# signals
signal lmb_clicked
signal lmb_released
# consts
const COLL_MASK_CARD = 1
const COLL_MASK_CARD_DECK = 4
# refs
var card_manager_ref
var deck_ref


func _ready() -> void:
	card_manager_ref = $"../card_manager"
	deck_ref = $"../deck"
	
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			emit_signal("lmb_clicked")
			raycast_at_cursor()
		else:
			emit_signal("lmb_released")

	

func raycast_at_cursor():
	#
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		var result_coll_mask = result[0].collider.collision_mask
		# card clicked
		if result_coll_mask == COLL_MASK_CARD:
			var card_found = result[0].collider.get_parent()
			if card_found:
				card_manager_ref.start_drag(card_found)
		# deck clicked
		elif result_coll_mask == COLL_MASK_CARD_DECK:
				deck_ref.draw_card()
		
		
