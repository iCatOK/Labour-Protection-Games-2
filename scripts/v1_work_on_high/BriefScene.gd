extends Control

export var brief_text: TextFile

func _ready():
	var data = brief_text.get_text()
	$Label.text = brief_text.to_string()
	print(brief_text.text)

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/menu/Variant Choosing.tscn")
