extends Control

onready var answers_container = $TestElements/AnswersContainer
var answer_button_node = preload("res://scenes/common/AnswerButton.tscn")
var choosen_buttons: Array

var questions: Array
var question_count: int = 0
var current_question_index = 0
var is_current_question_multi_answers: bool = false

var right_answers: int = 0

func _ready():
	questions = Global.config.test_questions
	question_count = questions.size()
	_set_question()
		
func _on_answer(choosen_button: AnswerButton):
	var question_index = choosen_button.question_index
	var answer_index = choosen_button.answer_index
	var answer_status = "Answered" if choosen_button.is_choosen else "Answer deleted"
	if not is_current_question_multi_answers:
		_clear_last_button()
	if choosen_button.is_choosen:
		choosen_buttons.append(choosen_button)
	else:
		_delete_button_from_choosen(choosen_button)
	print("[test step] %s: question #%s, answer #%s" % [answer_status, question_index, answer_index])
	print("[test step] correct answers: %s" % [choosen_buttons])
	
func _clear_last_button():
	if choosen_buttons.size() > 0:
		var question_index = choosen_buttons[0].question_index
		var answer_index = choosen_buttons[0].answer_index
		print("[test step] Clearing last choosen question #%s, answer #%s" % [question_index, answer_index])
		choosen_buttons[0].set_choosen(false)
		choosen_buttons.clear()
		
func _set_question():
	var question = questions[current_question_index]
	var answers = question.answers
	self.is_current_question_multi_answers = question.is_multi
	$TestElements/QuestionHeader.text = question.text
	for answer in answers:
		var answer_text = answer.text
		var answer_index = answer.index
		var is_correct = answer.is_correct
		var new_answer_node = answer_button_node.instance()
		new_answer_node.init(answer_text, current_question_index, answer_index, is_correct)
		new_answer_node.connect_on_choose_signal(self, "_on_answer")
		answers_container.add_child(new_answer_node)
		
func _delete_button_from_choosen(choosen_button: AnswerButton):
	for button in choosen_buttons:
		if button.answer_index == choosen_button.answer_index:
			choosen_buttons.erase(button)

func _all_answers_correct() -> bool:
	var correct: bool = true
	for button in choosen_buttons:
		if not button.is_correct:
			correct = false
			break
	print("[test step] MultiValidation: question #%s correct = %s" % [current_question_index, correct])
	return correct

func _on_NextButton_gui_input(event):
	if event.is_action_pressed("ui_click"):
		if not choosen_buttons.size() > 0:
			return
	
		if is_current_question_multi_answers and _all_answers_correct():
			right_answers += 1
	
		if not is_current_question_multi_answers and choosen_buttons[0].is_correct:
			print("[test step] SingleValidation: question #%s correct = %s" % [current_question_index, choosen_buttons[0].is_correct])
			right_answers += 1
		
		if current_question_index == question_count - 2:
			$TestElements/NavigationButtons/NextButton/Label.text = "Завершить"
	
		if current_question_index == question_count - 1:
			Global.set_step_score("test_step", right_answers, 0)
			get_tree().change_scene("res://scenes/common/Results.tscn")
		else:
			choosen_buttons.clear()
			Global.delete_children($TestElements/AnswersContainer)
			current_question_index += 1
			_set_question()
