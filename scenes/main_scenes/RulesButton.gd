extends Button

func _pressed():
	$"../RulesCorner".visible = true
	get_tree().paused = true
