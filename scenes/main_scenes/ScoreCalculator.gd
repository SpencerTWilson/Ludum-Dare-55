extends Node2D

var score: int = 0

var can_summon_ribbon = true

func _ready():
	DemonManager.new_season.connect(_new_season)

func _new_season():
	can_summon_ribbon = true

func _on_card_slot_slot_selected(_card):
	score = 0
	for card in $CardSlot.cards:
		score += 1
	
	for card in $CardSlot.cards:
		if card.tags.has("special"):
			score += 5
			DemonManager._special_summon()
	
	var red_ribbon_count = 0
	for card in $CardSlot.cards:
		if card.tags.has("red_ribbon"):
			red_ribbon_count += 1
	
	var blue_ribbon_count = 0
	for card in $CardSlot.cards:
		if card.tags.has("blue_ribbon"):
			blue_ribbon_count += 1
	
	var poetry_ribbon_count = 0
	for card in $CardSlot.cards:
		if card.tags.has("poetry_ribbon"):
			poetry_ribbon_count += 1
	var total_ribons = blue_ribbon_count + poetry_ribbon_count + red_ribbon_count
	
	if total_ribons > 2 and can_summon_ribbon:
		DemonManager._summon_new_ribbon()
		can_summon_ribbon = false
	
	score += (blue_ribbon_count as int / 3) * 10
	score += (red_ribbon_count as int / 5) * 10
	score += (poetry_ribbon_count as int / 3) * 10
	
	DemonManager.season_petals = score
	DemonManager.scores_updated.emit()
