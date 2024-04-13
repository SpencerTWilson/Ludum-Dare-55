extends Button

@export var scene_path: String

func _pressed():
	AudioManager._play_clip(load("res://assets/sounds/kenney_rpg_audio/Audio/drawKnife1.ogg"),"UI")
	get_tree().change_scene_to_file(scene_path)
