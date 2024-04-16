extends Node2D

@export var demon_art_1: Texture2D
@export var demon_art_2: Texture2D
var arts: Array = []

var on_screen: bool = false

var deal: String

var is_guide: bool = true

@export var demon_noise_enter: AudioStream
@export var demon_noise_accept: AudioStream
@export var demon_noise_decline: AudioStream

@export var guide_art: Texture2D
@export var guide_enter: AudioStream
@export var guide_leave: AudioStream

var deals: Dictionary = {
	"mult": {
		"text": "You've caught my interest. You may [color=red]summon[/color] me and I will multiply the next rounds petals by 2, but I will require something of you, 2 of your cards from your hand next season.",
		"func": next_mult.bind(2, 2),
	},
	"mult_extreme": {
		"text": "You've caught my interest. You may [color=red]summon[/color] me and I will multiply the next rounds petals by 6, but I will require something of you, 5 of your cards from your hand next season.",
		"func": next_mult.bind(6, 5),
	},
	"hand_grow": {
		"text": "You've caught my interest. You may [color=red]summon[/color] me and I will add 5 cards to your next hand, but I will require something of you, a third of the next season's petals.",
		"func": next_mult.bind(-0.3, -5),
	},
	"small_hand_grow": {
		"text": "You've caught my interest. You may [color=red]summon[/color] me and I will add 2 cards to your next hand, but I will require something of you, 4 petals.",
		"func": little_card_draw,
	},
	"add_ribbon": {
		"text": "You've caught my interest. You may [color=red]summon[/color] me and I will add 8 random ribbon cards to your deck, but I will require something of you, 10 petals.",
		"func": add_ribbons,
	},
	"add_animal": {
		"text": "You've caught my interest. You may [color=red]summon[/color] me and I will add 5 random animal cards to your deck, but I will require something of you, 15 petals.",
		"func": add_animals,
	},
	"add_gold": {
		"text": "You've caught my interest. You may [color=red]summon[/color] me and I will add 2 random bright cards to your deck, but I will require something of you, 20 petals.",
		"func": add_gold,
	},
}

func _ready():
	arts = [demon_art_1, demon_art_2]
	position += Vector2.LEFT * 1000
	make_demon()

func _process(delta):
	if on_screen:
		position.x = lerp(position.x, 0.0, 5 * delta)
		$Panel4/HBoxContainer/SummonButton.disabled = false
		$Panel4/HBoxContainer/DeclineButton.disabled = false
	else:
		position.x = lerp(position.x, -455.0, 5 * delta)
		$Panel4/HBoxContainer/SummonButton.disabled = true
		$Panel4/HBoxContainer/DeclineButton.disabled = true

func make_demon():
	get_tree().paused = true
	on_screen = true

	if !is_guide:
		$Panel4/Label.text = "Oni"
		deal = deals.keys().pick_random()
		$Sprite2D.texture = arts[randi_range(0,1)]
		AudioManager._play_clip(demon_noise_enter, "SFX")
		$Panel4/RichTextLabel.text = deals[deal]["text"]
		$Panel4/HBoxContainer/SummonButton.visible = true
	else:
		$Panel4/Label.text = "Earless Monk"
		$Sprite2D.texture = guide_art
		AudioManager._play_clip(guide_enter, "SFX")
		$Panel4/RichTextLabel.text = "The goal is to gather [color=Orchid]flower petals![/color]
To do this you must match cards in your hand with cards that share a month with it in the card pool.
Simply drag a card into the play slot. You must gather enough petals to out pace the season! But don't worry the first two seasons have no petal requirement to allow you to prepare. Oni will visit you once a year when they notice you. and completeling rituals will boost your deck."
		$Panel4/HBoxContainer/SummonButton.visible = false

func little_card_draw():
	$"../Deck".remove_cards = -2
	DemonManager.total_petals -= 4
	
func next_mult(mult: float, remove: int):
	$"../CollectedCards".mult += mult
	$"../Deck".remove_cards = remove

func add_ribbons():
	DemonManager.total_petals -= 10
	for i in range(8):
		DemonManager._summon_new_ribbon()
	
func add_animals():
	DemonManager.total_petals -= 15
	for i in range(5):
		DemonManager._summon_new_animal()

func add_gold():
	DemonManager.total_petals -= 20
	for i in range(2):
		DemonManager._add_new_gold()

func _on_summon_button_pressed():
	on_screen = false
	AudioManager._play_clip(demon_noise_accept, "SFX")
	get_tree().paused = false
	deals[deal]["func"].call()
	DemonManager.scores_updated.emit()
	DemonManager.demon_done.emit()

func _on_decline_button_pressed():
	on_screen = false
	if is_guide:
		AudioManager._play_clip(guide_leave, "SFX")
		is_guide = false
	else:
		AudioManager._play_clip(demon_noise_decline, "SFX")
	get_tree().paused = false
	DemonManager.demon_done.emit()
