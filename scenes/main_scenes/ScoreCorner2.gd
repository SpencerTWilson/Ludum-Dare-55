extends Control

func _update_gameover_scores():
	$VBoxContainer/ScoreLabel.text = "%d ~ Total Petals" % (DemonManager.total_petals + DemonManager.season_petals)
	$VBoxContainer/QuotaLabel.text = "%d ~ Required Petals" % DemonManager.required_petals_season
