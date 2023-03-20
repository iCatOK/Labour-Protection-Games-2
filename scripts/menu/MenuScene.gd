extends Control

# Contains global methods for whole scene
# Like: escape scene handling

func _ready():
	OS.set_window_maximized(true)

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		# close the game, if Esc is pressed
		get_tree().quit()
		
		


func _on_Change_Scene_Button_pressed():
	pass # Replace with function body.
