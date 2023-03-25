extends Control

export var sign_step_path: String

var step_valid_indexes = Global.config["second_step_valid_indexes"]
var step_player_indexes = []

var cell_node = preload("res://scenes/common/ImageCell.tscn")
onready var cell_container = $ProtectorsHeader/AvailableProtectorsList/GridContainer
onready var choosen_container = $ChoosedProtectorsHeader/ChoosedProtectorsList/GridContainer
onready var cell_info = $ProtectorInfo

func _ready():
	print("[protection step] Valid Second Step Indexes: %s" % [step_valid_indexes])
	for child in cell_container.get_children():
		var cell: ImageCell = (child as ImageCell)
		_connect_cell_signals(cell)

func _create_cell(cell):
	print("[protection step] choosing cell")
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
	print("[protection step] Current player indexes: %s" % [step_player_indexes])
	cell.queue_free()

func _on_NextButton_pressed():
	var correct_answers_count: int = 0
	var wrong_answers_count: int = 0
	var step_player_indexes_size = step_player_indexes.size()
	var step_valid_indexes_size = step_valid_indexes.size()
	var min_size = min(step_player_indexes_size, step_valid_indexes_size)
	print(min_size)
	for i in step_player_indexes_size:
		var player_index = step_player_indexes[i]
		if not (player_index in step_valid_indexes):
			print("[checking] %s - wrong" % player_index)
			wrong_answers_count += 1
		else:
			print("[checking] %s - correct" % player_index)
			correct_answers_count += 1
	print("[checking] Player choosed correctly %s protectors out of %s" % [correct_answers_count, step_valid_indexes_size])
	Global.set_step_score("protection_step", correct_answers_count, wrong_answers_count)
	get_tree().change_scene(sign_step_path)

func _on_ShowBriefButton_pressed():
	$Hint.show()
	
func _set_clicked_item_info(cell):
	cell_info.set_info(cell)

func _connect_cell_signals(cell: ImageCell):
	cell.connect_cell_click_signal(self, '_create_cell')
	cell.connect_cell_info_click_signal(self, '_set_clicked_item_info')


