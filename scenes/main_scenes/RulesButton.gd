extends Button

func _pressed():
	if !$"../RulesCorner".visible:
		$"../RulesCorner".visible = true
		get_tree().paused = true
	else:
		$"../RulesCorner".visible = false
		get_tree().paused = false
		
	AudioManager._play_clip(load("res://assets/sounds/kenney_rpg_audio/Audio/drawKnife1.ogg"), "UI")
