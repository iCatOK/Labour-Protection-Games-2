extends Control

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		# return to menu
		get_tree().change_scene("res://scenes/menu/Menu.tscn")
