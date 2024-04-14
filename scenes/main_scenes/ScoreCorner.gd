extends Control

func _ready():
	DemonManager.scores_updated.connect(_update_displays)
	_update_displays()
	
func _update_displays():
	$VBoxContainer/ScoreLabel.text = "%d ~ Total Petals" % (DemonManager.total_petals + DemonManager.season_petals)
	$VBoxContainer/QuotaLabel.text = "%d ~ Required Petals" % DemonManager.required_petals_season
