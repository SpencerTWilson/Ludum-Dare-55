extends Node

signal scores_updated
signal new_season

var season_count: int = 0

var season_petals: int = 0

var total_petals: int = 0
var required_petals_season: int = 0
var last_required_petals: int = 0

var extra_flip: bool = false

var special_summon: bool = false
var bird_ribbon_gold: bool = false
var summon_animals: bool = false

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

func _add_new_gold():
	var cards_to_add: Array = []
	
	for card_type in CardManager.card_types:
		if CardManager.card_types[card_type]["tags"].has("gold"):
			cards_to_add.append(CardManager.card_types[card_type])
	if cards_to_add.size() > 0:
		get_tree().get_nodes_in_group("deck")[0]._add_cards([cards_to_add.pick_random()])

func _summon_new_animal():
	var cards_to_add: Array = []
	
	for card_type in CardManager.card_types:
		if CardManager.card_types[card_type]["tags"].has("animal"):
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

func _summon_bird_ribbon_gold():
	if !bird_ribbon_gold:
		bird_ribbon_gold = true
		get_tree().get_nodes_in_group("deck")[0]._add_cards([CardManager.card_types["august_gold"]])

func _summon_animals():
	if !summon_animals:
		summon_animals = true
		var cards_to_add: Array = []
		
		for card_type in CardManager.card_types:
			if CardManager.card_types[card_type]["tags"].has("animal") and !CardManager.card_types[card_type]["tags"].has("bird"):
				cards_to_add.append(CardManager.card_types[card_type])
		if cards_to_add.size() > 0:
			get_tree().get_nodes_in_group("deck")[0]._add_cards(cards_to_add)
