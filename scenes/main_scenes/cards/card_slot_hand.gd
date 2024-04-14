extends CardSlot

func get_card_pos(card: Card):
	var card_spaced = (cards.find(card) - (cards.size() as float / 2) + 0.5) * 150
	return global_position + Vector2(card_spaced, 0)

func _select(card: Card, from_deck: bool = false):
	if card.position.x < global_position.x:
		cards.insert(0, card)
	else:
		cards.append(card)
	card.rest_slot = self
