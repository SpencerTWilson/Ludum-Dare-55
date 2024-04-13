extends HSlider

@export var volume_type: String
@export var sound_to_play: AudioStream

func _ready():
	value = OptionsManager.options["Audio"][volume_type + " Volume"]

func _value_changed(new_value):
	OptionsManager.options["Audio"][volume_type + " Volume"] = new_value
	OptionsManager.options_updated.emit()

func _on_drag_ended(_value):
	AudioManager._play_clip(sound_to_play, volume_type)
