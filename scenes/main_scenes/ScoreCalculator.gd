extends Node2D

var score: int = 0

var can_summon_ribbon = true
var can_summon_animal = true
var can_summon_gold = true

func _ready():
	DemonManager.new_season.connect(_new_season)

func _new_season():
	can_summon_ribbon = true
	can_summon_animal = true
	can_summon_gold = true
	
	if DemonManager.season_count % 4 == 2:
		$"../Demon Head".make_demon()

func _on_card_slot_slot_selected(_card, from_deck):
	score = 0
	
	#PLAINS / SPECIALS
	for card in $CardSlot.cards:
		score += 1
	
	for card in $CardSlot.cards:
		if card.tags.has("special"):
			#this is ontop of the regualar 1
			score += 1
			DemonManager._special_summon()
	
	#RIBBONS
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
	var total_ribbons = blue_ribbon_count + poetry_ribbon_count + red_ribbon_count
	
	if total_ribbons > 2 and can_summon_ribbon:
		DemonManager._summon_new_ribbon()
		can_summon_ribbon = false
	
	score += (blue_ribbon_count as int / 3) * 15
	score += (total_ribbons as int / 5) * 20
	score += (poetry_ribbon_count as int / 3) * 15
	
	var bird_count = 0
	for card in $CardSlot.cards:
		if card.tags.has("bird"):
			bird_count += 1
			if card.tags.has("three_bird"):
				#two more than the one we normally do
				bird_count += 2
	
	if total_ribbons < bird_count:
		DemonManager._summon_bird_ribbon_gold()
		
	score += (bird_count as int / 5) * 50
	
	var animal_count = 0
	for card in $CardSlot.cards:
		if card.tags.has("animal"):
			animal_count += 1
	
	if animal_count > 3 and can_summon_animal: 
		DemonManager._summon_new_animal()
		can_summon_animal = false
	
	var plain_count = 0
	for card in $CardSlot.cards:
		if card.tags.has("plain"):
			plain_count += 1
	if plain_count <= 0:
		DemonManager._summon_animals()
	
	score += animal_count * 8
	
	var gold_count = 0
	for card in $CardSlot.cards:
		if card.tags.has("gold"):
			gold_count += 1
	
	if gold_count > 3:
		for card in $CardSlot.cards:
			if card.tags.has("november") and card.tags.has("gold"):
				score += 100
	
	if $CardSlot.cards.size() > 20 and can_summon_gold:
		can_summon_gold = false
		DemonManager._add_new_gold()
	
	score += gold_count * 25
	
	DemonManager.season_petals = score
	DemonManager.scores_updated.emit()
