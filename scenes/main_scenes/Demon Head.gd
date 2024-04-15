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
	"draw_card": {
		"text": "card draw that cost 5 points to use but I take 10 points each round.",
		"func": start_card_draw,
	},
	"ribbon_mult": {
		"text": "ribbons * 2 points but the deck looses up to 5 ribbons",
		"func": start_ribbon_mult,
	},
	"extra_table_slot": {
		"text": "extra table slot but I remove 3 random cards",
		"func": start_extra_table_slot,
	},
	"plain eater": {
		"text": "I take 3 random plain cards but I take 100 points",
		"func": steal_plain_cards,
	}
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
		$Panel4/RichTextLabel.text = "I am a guide!"
		$Panel4/HBoxContainer/SummonButton.visible = false

func start_card_draw():
	print("hey")
	#DemonManager.extra_card_draw = true
	
func start_ribbon_mult():
	print("hey")
	#DemonManager.ribbon_mult += 1

func start_extra_table_slot():
	print("hey")
	pass
	
func steal_plain_cards():
	pass


func _on_summon_button_pressed():
	on_screen = false
	AudioManager._play_clip(demon_noise_accept, "SFX")
	deals[deal]["func"].call()
	get_tree().paused = false
	

func _on_decline_button_pressed():
	on_screen = false
	if is_guide:
		AudioManager._play_clip(guide_leave, "SFX")
		is_guide = false
	else:
		AudioManager._play_clip(demon_noise_decline, "SFX")
	get_tree().paused = false
