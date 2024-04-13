extends Node

var active_slots: Array = []
var max_dist: float = 300

func get_closest_slot(card: Card):
	var cur_closest_dist: float = max_dist
	var cur_closest_slot: CardSlot = null
	
	for slot in active_slots:
		var slot_dist = slot.position.distance_to(card.position)
		if slot_dist <= cur_closest_dist:
			cur_closest_dist = slot_dist
			cur_closest_slot = slot
	
	return cur_closest_slot
