extends Node

var active_slots: Array = []
var max_dist: float = 350

func get_closest_slot(card: Card, ignore_max_dist: bool = false):
	var cur_closest_dist: float = max_dist
	var cur_closest_slot: CardSlot = null
	
	for slot in active_slots:
		var slot_dist = slot.global_position.distance_to(card.global_position)
		if slot.whitelisted_tag == "" or card.tags.has(slot.whitelisted_tag):
			if slot.can_drop:
				if slot.cards.size() < slot.num_cards_allowed:
					if slot_dist <= cur_closest_dist or ignore_max_dist:
						cur_closest_dist = slot_dist
						cur_closest_slot = slot
	
	return cur_closest_slot
