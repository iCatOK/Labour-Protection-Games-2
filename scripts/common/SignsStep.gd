extends Control

export var emergency_step_scene_path: String

var step_valid_indexes = []
var step_player_indexes = []

var cell_node = preload("res://scenes/common/ImageCell.tscn")
onready var cell_container = $SafetySigns/AvailableSignsList/GridContainer
onready var choosen_container = $ChoosedSigns/ChoosedSignsList/GridContainer

func _ready():
	step_valid_indexes = Global.config["sign_step_valid_indexes"]
	print("[sign step] Valid Sign Step Indexes: %s" % [step_valid_indexes])
	for child in cell_container.get_children():
		var cell: ImageCell = (child as ImageCell)
		_connect_cell_signals(cell)
	Global.add_dialog(self, "/signs_step")

func _create_cell(cell):
	print("[sign step] choosing cell")
	var new_cell = cell_node.instance()
	new_cell.init_cell(cell)
	_connect_cell_signals(new_cell)
	if not cell.choosen:
		choosen_container.add_child(new_cell)
		choosen_container.move_child(new_cell, 0)
		step_player_indexes.push_back(new_cell.index)
	else:
		cell_container.add_child(new_cell)
		cell_container.move_child(new_cell, 0)
		step_player_indexes.erase(new_cell.index)
	print("[sign step] Current player indexes: %s" % [step_player_indexes])
	cell.queue_free()

func _on_NextButton_pressed():
	var correct_answers_count: int = 0
	var wrong_answers_count: int = 0
	var step_player_indexes_size = step_player_indexes.size()
	var step_valid_indexes_size = step_valid_indexes.size()
	var min_size = min(step_player_indexes_size, step_valid_indexes_size)
	for i in step_player_indexes_size:
		var player_index = step_player_indexes[i]
		if not (player_index in step_valid_indexes):
			print("[sign step checking] %s - wrong" % player_index)
			wrong_answers_count += 1
		else:
			print("[sign step checking] %s - correct" % player_index)
			correct_answers_count += 1
	print("[sign step checking] Player choosed correctly %s signs out of %s" % [correct_answers_count, step_valid_indexes_size])
	Global.set_step_score("sign_step", correct_answers_count, wrong_answers_count)
	get_tree().change_scene(emergency_step_scene_path)

func _on_ShowBriefButton_pressed():
	$Hint.show()

func _connect_cell_signals(cell: ImageCell):
	cell.connect_cell_click_signal(self, '_create_cell')


