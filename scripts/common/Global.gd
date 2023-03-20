extends Node

var config: Dictionary = read_json_file("res://gfx/configs/config_1.json")

var player_score: Dictionary = {}
var valid_score: Dictionary = {
		"document_step": config["индексы_ответов_тест_1"].size(),
		"protection_step": config["second_step_valid_indexes"].size(),
		"sign_step": 2,
		"emergency_step": 2
	}

func _ready():
	pass
	
func set_step_score(step_name: String, score: int, wrong_score: int):
	var step_valid_score = valid_score[step_name]
	var passed = "Пройдено" if (score >= step_valid_score) else "Не пройдено"
	var player_calulated_score = max(0, score - wrong_score)
	player_score[step_name] = [player_calulated_score, step_valid_score, passed]
	print("[global] Step %s complete, player_score: %s" % [step_name, player_calulated_score])
	print(player_score)
	
func read_json_file(filename):
	var file = File.new()
	file.open(filename, file.READ)
	var text = file.get_as_text()
	var json_data = parse_json(text)
	file.close()
	return json_data
