extends Node

# scene with pages of variant
export var document_pages_scene: String
export var protection_step_path: String

func _ready():
	var pages: DocumentPagesChecker = load(document_pages_scene).instance()
	$MarginContainer/Rows.add_child(pages)
	$MarginContainer/Rows/ToolBar/NextButton.connect("pressed", pages, "_on_NextButton_pressed")


func _on_NextButton_pressed():
	get_tree().change_scene(protection_step_path)
