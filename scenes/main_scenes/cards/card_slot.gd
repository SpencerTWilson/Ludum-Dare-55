extends Node2D
class_name CardSlot

signal slot_selected(card)

@export var whitelisted_tag: String = ""
@export var num_cards_allowed: int = 1
var cards: Array = []

func _ready():
	SlotManager.active_slots.append(self)

func _select(card: Card):
	cards.append(card)
	card.rest_slot = self
	slot_selected.emit(card)

func get_card_pos(_card: Card):
	return global_position

func _remove_card(card: Card):
	if cards.has(card):
		cards.erase(card)
