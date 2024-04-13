extends Sprite2D
class_name Card

@export var card_name: String
@export var tags: Array

var front_texture: Texture2D
var back_texture: Texture2D = preload("res://assets/textures/hanafuda/card_back.png")

var selected: bool = false

var selected_scale: float = 0.055
var unselected_scale: float = 0.05

var selected_sound: AudioStream = preload("res://assets/sounds/kenney_casino_audio/Audio/cardPlace1.ogg")
var unselected_sound: AudioStream = preload("res://assets/sounds/kenney_casino_audio/Audio/cardPlace2.ogg")

var flipped: bool = false
var flipping: bool = false

@export var rest_point: Vector2

func _ready():
	rest_point = SlotManager.active_slots[0].position
	front_texture = texture

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("select") and !flipping:
		selected = true
		AudioManager._play_clip(selected_sound, "SFX")
	
	if Input.is_action_just_pressed("info") and !selected:
		flipping = true
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
		global_position = lerp(global_position, rest_point, 25 * delta)
		scale = lerp(scale, Vector2.ONE * unselected_scale, 25 * delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed and selected:
			selected = false
			AudioManager._play_clip(unselected_sound, "SFX")
			var new_slot: CardSlot = SlotManager.get_closest_slot(self)
			if new_slot != null:
				rest_point = new_slot.position
