extends Control

var label_node = preload("res://scenes/common/CommonLabel.tscn")

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
	
	for step in Global.player_score.keys():
		set_step_result_row(step)

func set_step_result_row(step_name: String):
	if Global.player_score.has(step_name):
		var step_info = Global.player_score[step_name]
		
		var step_name_label = label_node.instance()
		var step_score_label = label_node.instance()
		var step_report_label = label_node.instance()
		
		step_name_label.text = Global.step_name_map[step_name]
		step_score_label.text = "%s/%s баллов" % [step_info[0], step_info[1]]
		step_report_label.text = Global.player_score[step_name][2]
		
		$StageResults.add_child(step_name_label)
		$StageResults.add_child(step_score_label)
		$StageResults.add_child(step_report_label)

func _on_ShowBriefButton_pressed():
	get_tree().change_scene("res://scenes/menu/Menu.tscn")
