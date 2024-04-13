extends Node

signal options_updated()

var options: Dictionary = {}
var options_file: String = "res://scenes/autoloads/Options/options.json"

#Create the options screen, pause the game
func _open_options_menu():
	pass

#Should grab the saved options
func _ready():
	var options_json_string: String = FileAccess.get_file_as_string(options_file)
	options = JSON.parse_string(options_json_string)
	#just because we technically changed the options
	options_updated.emit()

func _options_updated():
	var file = FileAccess.open(options_file, FileAccess.WRITE)
	file.store_string(JSON.stringify(options))
	file.close()
	options_updated.emit()
