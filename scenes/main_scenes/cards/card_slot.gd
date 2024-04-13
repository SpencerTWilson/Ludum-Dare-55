extends Node2D
class_name CardSlot

func _ready():
	SlotManager.active_slots.append(self)

func _select(card: Card):
	card.rest_point = global_position
