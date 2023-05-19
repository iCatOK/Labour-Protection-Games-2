extends Control
class_name AnswerButton

export var pressed_color: Color = Color("2f9366")
export var normal_color: Color = Color("2a2a43")

var option_name: String = "Ответ на вопрос"
var is_choosen: bool = false
var is_correct: bool = false
var answer_index: int = -1
var question_index: int = -1

signal on_choose(button)

func _ready():
	$Label.text = option_name
	
func init(option_name, question_index, answer_index, is_correct):
	self.option_name = "   " + option_name + "   "
	self.question_index = question_index
	self.answer_index = answer_index
	self.is_correct = is_correct
	
func connect_on_choose_signal(target, method_name):
	connect("on_choose", target, method_name)
	
func set_choosen(is_choosen):
	self.is_choosen = is_choosen
	update_button()
	
func update_button():
	$Background.color = pressed_color if is_choosen else normal_color


func _on_AnswerButton_gui_input(event):
	if event.is_action_pressed("ui_click"):
		print("[answer button] Choosed answer #%s for question #%s" % [answer_index, question_index])
		set_choosen(not is_choosen)
		emit_signal("on_choose", self)
