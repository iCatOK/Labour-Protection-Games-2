extends Control

onready var answers_container = $TestElements/AnswersContainer
var answer_button_node = preload("res://scenes/common/AnswerButton.tscn")
var last_choosen_button: AnswerButton

var questions = Global.config.test_questions
var question_count = questions.size()
var current_question_index = 0

var right_answers: int = 0

func _ready():
	_set_question()
		
func _on_answer(choosen_button: AnswerButton):
	var question_index = choosen_button.question_index
	var answer_index = choosen_button.answer_index
	var answer_status = "Answered" if choosen_button.is_choosen else "Answer deleted"
	_clear_choosen_before()
	last_choosen_button = choosen_button
	print("[test step] %s: question #%s, answer #%s" % [answer_status, question_index, answer_index])
	
func _clear_choosen_before():
	if last_choosen_button:
		var question_index = last_choosen_button.question_index
		var answer_index = last_choosen_button.answer_index
		print("[test step] Clearing last choosen question #%s, answer #%s" % [question_index, answer_index])
		last_choosen_button.set_choosen(false)
		
func _set_question():
	var question = questions[current_question_index]
	var answers = question.answers
	$TestElements/QuestionHeader.text = question.text
	for answer in answers:
		var answer_text = answer.text
		var answer_index = answer.index
		var is_correct = answer.is_correct
		var new_answer_node = answer_button_node.instance()
		new_answer_node.init(answer_text, current_question_index, answer_index, is_correct)
		new_answer_node.connect_on_choose_signal(self, "_on_answer")
		answers_container.add_child(new_answer_node)

func _on_NextButton_pressed():
	if last_choosen_button.is_correct:
		right_answers += 1
		
	if current_question_index == question_count - 2:
		$TestElements/NavigationButtons/NextButton.text = "Завершить"
	
	if current_question_index == question_count - 1:
		Global.set_step_score("test_step", right_answers, 0)
		get_tree().change_scene("res://scenes/common/Results.tscn")
	else:
		last_choosen_button = null
		Global.delete_children($TestElements/AnswersContainer)
		current_question_index += 1
		_set_question()
