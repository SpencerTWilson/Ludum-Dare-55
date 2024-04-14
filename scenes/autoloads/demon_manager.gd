extends Node

signal scores_updated
signal new_season

var season_count: int = 0

var season_petals: int = 0

var total_petals: int = 0
var required_petals_season: int = 1

var extra_flip: bool = false

var special_summon: bool = false

func _special_summon():
	if !special_summon:
		special_summon = true
		
		var cards_to_add: Array = []
		
		for card_type in CardManager.card_types:
			if CardManager.card_types[card_type]["tags"].has("red_ribbon"):
				cards_to_add.append(CardManager.card_types[card_type])
		if cards_to_add.size() > 0:
			get_tree().get_nodes_in_group("deck")[0]._add_cards(cards_to_add)

func _summon_new_ribbon():
	var cards_to_add: Array = []
	
	for card_type in CardManager.card_types:
		if CardManager.card_types[card_type]["tags"].has("ribbon"):
			cards_to_add.append(CardManager.card_types[card_type])
	if cards_to_add.size() > 0:
		get_tree().get_nodes_in_group("deck")[0]._add_cards([cards_to_add.pick_random()])

func _ribbon_summon():
	var cards_to_add: Array = []
	
	for card_type in CardManager.card_types:
		if CardManager.card_types[card_type]["tags"].has("bird"):
			cards_to_add.append(CardManager.card_types[card_type])
	if cards_to_add.size() > 0:
		get_tree().get_nodes_in_group("deck")[0]._add_cards(cards_to_add)
