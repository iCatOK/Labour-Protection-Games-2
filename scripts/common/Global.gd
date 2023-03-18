extends Node

var player_score: Dictionary = {}

var valid_score: Dictionary = {
		"document_step": 5,
		"protection_step": 3,
		"sign_step": 4,
		"emergency_step": 2
	}

func _ready():
	pass
	
func set_step_score(step_name: String, score: int):
	player_score[step_name] = score
	print("[global] Step %s complete, player_score: %s" % [step_name, score])
	print(player_score)
	
func read_json_file(filename):
	var file = File.new()
	file.open(filename, file.READ)
	var text = file.get_as_text()
	var json_data = parse_json(text)
	file.close()
	return json_data
