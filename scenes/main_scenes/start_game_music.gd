extends Panel

func _ready():
	AudioManager._stop_music()
	AudioManager._play_music(load("res://assets/sounds/kenney_casino_audio/Audio/gam jam.ogg"))
