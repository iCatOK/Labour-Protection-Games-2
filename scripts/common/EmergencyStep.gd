extends Control
class_name EmergencyStep


func _ready():
	pass

func _on_Dialog_dialogic_signal(value):
	if (value):
		call(value)
	
func fix_good_points():
	var points: int = int(Dialogic.get_variable("Good Points"))
	points = max(points, 0)
	Dialogic.set_variable("Good Points", str(points))

func set_results():
	var right_answers: int = int(Dialogic.get_variable("Good Points"))
	var wrong_answers: int = int(Dialogic.get_variable("Bad Points"))
	Global.set_step_score("emergency_step", right_answers, wrong_answers)
