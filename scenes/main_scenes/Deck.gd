extends Node2D

@export var table_slots: Array = []
@export var hand_slot: CardSlot

@export var card_scene: PackedScene

var deck_of_cards: Array = []

func _ready():
	var i: int = 0
	for slot in table_slots:
		table_slots[i] = get_node(slot)
		i += 1
	
	for card_type in CardManager.card_types.keys():
		if CardManager.card_types[card_type]["tags"].has("plain"):
			deck_of_cards.append(CardManager.card_types[card_type])
			deck_of_cards.append(CardManager.card_types[card_type])
	
	deck_of_cards.shuffle()
	
	#This is table  Cards
	for index in range(8):
		flip_card_to_slot(table_slots[index])
		await get_tree().create_timer(0.3).timeout
	#This is hand Cards
	for index in range(8):
		flip_card_to_slot(hand_slot)
		await get_tree().create_timer(0.3).timeout

func flip_card_to_slot(slot: CardSlot):
	var new_card = card_scene.instantiate()
	get_tree().get_nodes_in_group("card_manager")[0].add_child(new_card)
	slot._select(new_card)
	new_card.global_position = global_position
	new_card.flipped = true
	new_card.texture = new_card.back_texture
	new_card.flipping = true
	var new_card_type = deck_of_cards.pop_back()
	new_card.front_texture = new_card_type["texture"]
	new_card.tags = new_card_type["tags"]

#TODO:
#2. Make a Hanafuda Hand place that will calculate the hands you have
#3. Make a center bit that when you play or flip a card you are able to collect matching cards
#4. Make a score display
#5. Make a hand guide, that can expand
#6. Make a round tracker that can reset the round
#7. Make a deamon manager
#8. Make a deamon altar for satiating the deamons
#9. YEY! You did something!
