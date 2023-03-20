extends Control

var label_node = preload("res://scenes/common/CommonLabel.tscn")
var document_step_name = "Наряд допуск"
var protection_step_name = "Выбор СИЗ"

func _ready():
	var step_info: Array
	var step_name_header = label_node.instance()
	var player_score_header = label_node.instance()
	var report_header = label_node.instance()
	step_name_header.text = "Название этапа"
	player_score_header.text = "Количество баллов"
	report_header.text = "Прохождение"
	$StageResults.add_child(step_name_header)
	$StageResults.add_child(player_score_header)
	$StageResults.add_child(report_header)
	
	if Global.player_score.has("document_step"):
		step_info = Global.player_score.document_step
		var document_step_name_label = label_node.instance()
		var document_step_score_label = label_node.instance()
		var document_step_report_label = label_node.instance()
		document_step_name_label.text = document_step_name
		document_step_score_label.text = "%s/%s баллов" % [step_info[0], step_info[1]]
		document_step_report_label.text = Global.player_score.document_step[2]
		$StageResults.add_child(document_step_name_label)
		$StageResults.add_child(document_step_score_label)
		$StageResults.add_child(document_step_report_label)
	if Global.player_score.has("protection_step"):
		step_info = Global.player_score.protection_step
		var protection_step_name_label = label_node.instance()
		var protection_step_score_label = label_node.instance()
		var protection_step_report_label = label_node.instance()
		protection_step_name_label.text = protection_step_name
		protection_step_score_label.text = "%s/%s баллов" % [step_info[0], step_info[1]]
		protection_step_report_label.text = Global.player_score.protection_step[2]
		$StageResults.add_child(protection_step_name_label)
		$StageResults.add_child(protection_step_score_label)
		$StageResults.add_child(protection_step_report_label)


func _on_ShowBriefButton_pressed():
	get_tree().change_scene("res://scenes/menu/Menu.tscn")
