extends Sprite2D
class_name Card

@export var card_name: String
@export var tags: Array

var front_texture: Texture2D
var back_texture: Texture2D = preload("res://assets/textures/hanafuda/card_back.png")

var selected: bool = false
var locked: bool = false

var selected_scale: float = 0.055
var unselected_scale: float = 0.05

var selected_sound: AudioStream = preload("res://assets/sounds/kenney_casino_audio/Audio/cardPlace1.ogg")
var unselected_sound: AudioStream = preload("res://assets/sounds/kenney_casino_audio/Audio/cardPlace2.ogg")

var flipped: bool = false
var flipping: bool = false

@export var rest_slot: CardSlot

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("select") and !flipping and !locked:
		selected = true
		AudioManager._play_clip(selected_sound, "SFX")

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		scale = lerp(scale, Vector2.ONE * selected_scale, 25 * delta)
	elif flipping:
		scale = lerp(scale, Vector2(0,selected_scale), 25 * delta)
		if scale.x <= 0.001:
			flipping = false
			flipped = !flipped
			if flipped:
				texture = back_texture
			else:
				texture = front_texture
	else:
		global_position = lerp(global_position, rest_slot.get_card_pos(self), 10 * delta)
		scale = lerp(scale, Vector2.ONE * unselected_scale, 25 * delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed and selected:
			selected = false
			AudioManager._play_clip(unselected_sound, "SFX")
			var new_slot: CardSlot = SlotManager.get_closest_slot(self)
			if new_slot != null:
				rest_slot._remove_card(self)
				new_slot._select(self)
