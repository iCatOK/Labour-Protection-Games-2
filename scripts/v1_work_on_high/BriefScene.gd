extends Control

export(String, MULTILINE) var brief_text
export var document_step_scene: String
export var hint_mode: bool

func _ready():
	$Email/Label.text = brief_text
	if hint_mode:
		$Email/DocumentStepButton.text = "Скрыть"

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/menu/Variant Choosing.tscn")


func _on_DocumentStepButton_pressed():
	get_tree().change_scene(document_step_scene)
