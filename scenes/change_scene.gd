extends Button

@export var scene_path: String

func _pressed():
	AudioManager._play_clip(load("res://assets/sounds/kenney_rpg_audio/Audio/drawKnife1.ogg"),"UI")
	get_tree().paused = false
	DemonManager.season_count = 0

	DemonManager.season_petals = 0

	DemonManager.total_petals = 0
	DemonManager.required_petals_season = 0
	DemonManager.last_required_petals = 0

	DemonManager.extra_flip = false

	DemonManager.special_summon = false
	DemonManager.bird_ribbon_gold = false
	DemonManager.summon_animals = false
	
	SlotManager.active_slots.clear()
	get_tree().change_scene_to_file(scene_path)
