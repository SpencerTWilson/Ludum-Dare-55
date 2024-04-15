extends Button

func _pressed():
	get_tree().paused = false
	$"../..".visible = false
	AudioManager._play_clip(load("res://assets/sounds/kenney_rpg_audio/Audio/drawKnife1.ogg"), "UI")
