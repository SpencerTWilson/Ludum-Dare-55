extends Node2D

@export var table_slots: Array = []
@export var collected_cards: CardSlot
@export var hand: CardSlot

var collect_sound: AudioStream = preload("res://assets/sounds/kenney_rpg_audio/Audio/handleCoins2.ogg")

func _ready():
	var i: int = 0
	for slot in table_slots:
		table_slots[i] = get_node(slot)
		i += 1

func _on_card_slot_slot_selected(card):
	for slot in table_slots:
		if slot.cards.size() > 0:
			if slot.cards[0].tags.has(CardManager.get_month(card)):
				$CardSlot._remove_card(card)
				collected_cards._select(card)
				var collected_card = slot.cards[0]
				slot._remove_card(collected_card)
				collected_cards._select(collected_card)
				AudioManager._play_clip(collect_sound, "SFX")
				break
	
	if $CardSlot.cards.size() > 0:
		$CardSlot._remove_card(card)
		hand._select(card)
