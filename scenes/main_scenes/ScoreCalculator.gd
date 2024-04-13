extends Node2D

var score: int = 0

func _on_card_slot_slot_selected(_card):
	score = 0
	for card in $CardSlot.cards:
		score += 1
	DemonManager.season_petals = score
	DemonManager.scores_updated.emit()
