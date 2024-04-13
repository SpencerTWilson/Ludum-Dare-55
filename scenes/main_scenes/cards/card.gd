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

func _ready():
	front_texture = texture

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("select"):
		selected = true
		AudioManager._play_clip(selected_sound, "SFX")

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		scale = lerp(scale, Vector2.ONE * selected_scale, 25 * delta)
	else:
		scale = lerp(scale, Vector2.ONE * unselected_scale, 25 * delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			AudioManager._play_clip(unselected_sound, "SFX")
