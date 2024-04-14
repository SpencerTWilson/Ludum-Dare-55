extends Node2D

@export var table_slots: Array = []
@export var hand_slot: CardSlot

@export var collected_cards_slot: CardSlot

@export var card_scene: PackedScene

signal deck_empty

var deck_of_cards: Array = []

var shuffle_sound: AudioStream = preload("res://assets/sounds/kenney_casino_audio/Audio/cardFan2.ogg")
var shuffle_sound_2: AudioStream = preload("res://assets/sounds/kenney_casino_audio/Audio/cardFan1.ogg")

func _ready():
	var i: int = 0
	for slot in table_slots:
		table_slots[i] = get_node(slot)
		i += 1
	
	for card_type in CardManager.card_types.keys():
		if CardManager.card_types[card_type]["tags"].has("plain"):
			deck_of_cards.append(CardManager.card_types[card_type])
			deck_of_cards.append(CardManager.card_types[card_type])
	
	AudioManager._play_clip(shuffle_sound, "SFX")
	
	_set_up_round()
	
func _set_up_round():
	deck_of_cards.shuffle()
	
	#This is table  Cards
	for index in range(8):
		flip_card_to_slot(table_slots[index])
		await get_tree().create_timer(0.05).timeout
	#This is hand Cards
	for index in range(8):
		flip_card_to_slot(hand_slot)
		await get_tree().create_timer(0.05).timeout

func flip_card_to_slot(slot: CardSlot):
	var new_card_type = deck_of_cards.pop_back()
	if new_card_type != null:
		var new_card = card_scene.instantiate()
		get_tree().get_nodes_in_group("card_manager")[0].add_child(new_card)
		new_card.global_position = global_position
		new_card.flipped = true
		new_card.texture = new_card.back_texture
		new_card.flipping = true
		new_card.front_texture = new_card_type["texture"]
		new_card.tags = new_card_type["tags"]
		slot._select(new_card, true)
	else:
		deck_empty.emit()

func _next_round():
	DemonManager.total_petals += DemonManager.season_petals
	DemonManager.season_petals = 0
	DemonManager.required_petals_season = pow((DemonManager.season_count), 2) * 2.2
	
	if DemonManager.total_petals < floor(DemonManager.required_petals_season):
		$"../ScoreCorner2".visible = true
		DemonManager.season_count = 0

		DemonManager.season_petals = 0

		DemonManager.total_petals = 0
		DemonManager.required_petals_season = 0
		DemonManager.last_required_petals = 0

		DemonManager.extra_flip = false

		DemonManager.special_summon = false
		DemonManager.bird_ribbon_gold = false
		DemonManager.summon_animals = false
		get_tree().paused = true
	
	var emptied_board: bool = true
	for slot in table_slots:
		if slot.cards.size() > 0:
			emptied_board = false
	if emptied_board:
		DemonManager._add_new_gold()
	
	for card in hand_slot.cards:
		$CardSlot._select(card)
	hand_slot.cards.clear()
	
	for slot in table_slots:
		if slot.cards.size() > 0:
			var moving_card = slot.cards[0]
			$CardSlot._select(moving_card)
			slot._remove_card(moving_card)
	
	AudioManager._play_clip(shuffle_sound_2, "SFX")
	
	for card in collected_cards_slot.cards:
		$CardSlot._select(card)
		await get_tree().create_timer(0.05).timeout
	collected_cards_slot.cards.clear()
	
	await get_tree().create_timer(0.5).timeout
	
	AudioManager._play_clip(shuffle_sound, "SFX")
	
	for card in $CardSlot.cards:
		deck_of_cards.append({"texture": card.front_texture, "tags": card.tags})
		card.queue_free()
	$CardSlot.cards.clear()
	
	DemonManager.season_count += 1
	DemonManager.new_season.emit()
	DemonManager.scores_updated.emit()
	
	_set_up_round()
	
func _add_cards(cards_to_add: Array):
	for card_type in cards_to_add:
		var new_card = card_scene.instantiate()
		get_tree().get_nodes_in_group("card_manager")[0].add_child(new_card)
		new_card.global_position = $NewCardSpawnPos.global_position
		new_card.flipped = true
		new_card.texture = new_card.back_texture
		new_card.flipping = true
		new_card.front_texture = card_type["texture"]
		new_card.tags = card_type["tags"]
		$CardSlot._select(new_card)
		
		await get_tree().create_timer(0.05).timeout
	
	await get_tree().create_timer(0.5).timeout
	for card in $CardSlot.cards:
		deck_of_cards.append({"texture": card.front_texture, "tags": card.tags})
		card.queue_free()
	$CardSlot.cards.clear()
	
	AudioManager._play_clip(shuffle_sound_2, "SFX")
	deck_of_cards.shuffle()
	
#TODO:
#5. Make a hand guide, that can expand
#7. Make a deamon manager
#8. Make a deamon altar for satiating the deamons
#9. YEY! You did something!


func _on_end_season_button_pressed():
	_next_round()
