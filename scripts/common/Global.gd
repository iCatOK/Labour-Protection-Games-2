extends Node

var config: Dictionary = {} # read_json_file("res://gfx/configs/config_1.json")

var player_score: Dictionary = {}

var valid_score: Dictionary = {}

var is_visual_novel: bool = false
	
var step_name_map: Dictionary = {
	"document_step": "Наряд допуск",
	"protection_step": "Выбор СИЗ",
	"sign_step": "Выбор знаков опасности",
	"emergency_step": "Опасная ситуация",
	"test_step": "Тестирование"
}

static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

func _ready():
	# default init
	init_config("res://gfx/configs/config_1.json")
	
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

func init_config(path: String):
	config = read_json_file(path)
	valid_score = {
		"document_step": config["first_step_valid_indexes"].size(),
		"protection_step": config["second_step_valid_indexes"].size(),
		"sign_step": config["sign_step_valid_indexes"].size(),
		"emergency_step": 1,
		"test_step": config["test_questions"].size()
	}
	
func add_dialog(sender, timeline):
	if Global.is_visual_novel:
		var dialog = Dialogic.start(timeline)
		sender.add_child(dialog)
