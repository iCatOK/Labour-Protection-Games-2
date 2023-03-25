extends Button
class_name AnswerButton

var normal_button_style_box: StyleBox = preload("res://styles/color/button_color_normal.tres") as StyleBox
var normal_button_hovered_style_box: StyleBox = preload("res://styles/color/button_color_normal_hovered.tres") as StyleBox
var pressed_button_style_box: StyleBox = preload("res://styles/color/button_color_pressed.tres") as StyleBox
var pressed_button_hovered_style_box: StyleBox = preload("res://styles/color/button_color_pressed_hovered.tres") as StyleBox

var option_name: String = "Ответ на вопрос"
var is_choosen: bool = false
var is_correct: bool = false
var answer_index: int = -1
var question_index: int = -1

signal on_choose(button)

func _ready():
	text = option_name
	
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
	add_stylebox_override("normal", pressed_button_style_box if is_choosen else normal_button_style_box)
	add_stylebox_override("hover", pressed_button_hovered_style_box if is_choosen else normal_button_hovered_style_box)

func _on_AnswerButton_pressed():
	print("[answer button] Choosed answer #%s for question #%s" % [answer_index, question_index])
	set_choosen(not is_choosen)
	emit_signal("on_choose", self)
