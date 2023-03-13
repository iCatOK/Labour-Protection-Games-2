extends HBoxContainer

func _ready():
	pass

# close the game, if exit button is pressed
func _on_Exit_Button_pressed():
	get_tree().quit()
