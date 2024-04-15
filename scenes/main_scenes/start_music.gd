extends Node

@export var music_track: AudioStream

func _ready():
	AudioManager._stop_music()
	AudioManager._play_music(music_track)
	$"../Season".Season = randi_range(0,3)
