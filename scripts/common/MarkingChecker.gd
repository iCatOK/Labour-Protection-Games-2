extends Control
class_name MarkingChecker

const SUCCESS_MESSAGE: String = 'Вы справились с заданием! Идем дальше.'
const FAILURE_MESSAGE: String = 'Вы отметили не те ошибки! Попробуйте еще раз'

export(Array, NodePath) var wrong_markers
export var result_dialog_path: NodePath
export var valid_indexes_array_name: String #индексы_ответов_тест_1

var config: Dictionary = _read_json_file("gfx/configs/config_1.json")
var player_wrong_marker_indexes: Array = []
var valid_wrong_marker_indexes: Array
var last_result: bool = false

var result_dialog: AcceptDialog

signal marker_state_change(marked)


func _ready():
	valid_wrong_marker_indexes = config[valid_indexes_array_name]
	valid_wrong_marker_indexes.sort()
	print(valid_wrong_marker_indexes)
	
	result_dialog = get_node(result_dialog_path)
	_connect_wrong_marker_signals()
	
func _connect_wrong_marker_signals():
	for marker_path in wrong_markers:
		var marker: WrongMarker = get_node(marker_path)
		marker.connect("marked_event", self, "_on_marked_event")
		self.connect("marker_state_change", marker, "change_marked_state")


func _read_json_file(filename):
	var file = File.new()
	file.open(filename, file.READ)
	var text = file.get_as_text()
	var json_data = parse_json(text)
	file.close()
	return json_data
	

func _on_marked_event(data):
	var index: int = data['index']
	var marked: bool = data['marked']
	
	if marked and not index in player_wrong_marker_indexes:
		player_wrong_marker_indexes.push_back(index)
	if not marked and index in player_wrong_marker_indexes:
		player_wrong_marker_indexes.erase(index)
		
	print('[marking] player indexes: %s' % [player_wrong_marker_indexes])
	player_wrong_marker_indexes.sort()
	
	
func _check_marking_indexes_sorted():
	print('[checking] Check of sorted answers (player - valid answer)')
	var correct: bool = true
	
	if player_wrong_marker_indexes.size() != valid_wrong_marker_indexes.size():
		print('[checking] Answer not the same, too much/few')
		return false
		
	for i in player_wrong_marker_indexes.size():
		var player_index = player_wrong_marker_indexes[i]
		var valid_index =  valid_wrong_marker_indexes[i]
		print("%s - %s" % [player_index, valid_index])
		if player_index != valid_index:
			correct = false
			print('[checking] Answers is wrong: index #%s!' % player_index)
			
	if correct:
		print("[checking] Answers are right, congrats!")
		return true
	else:
		return false


func _on_DoneButton_pressed():
	var is_correct: bool = _check_marking_indexes_sorted()
	last_result = is_correct
	
	result_dialog.dialog_text = SUCCESS_MESSAGE if is_correct else FAILURE_MESSAGE
	result_dialog.show()


func _on_ResultDialog_confirmed():
	player_wrong_marker_indexes.clear()
	emit_signal("marker_state_change", false)
