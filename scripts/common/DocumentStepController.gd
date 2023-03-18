extends Node

# scene with pages of variant
export var document_pages_scene: String

func _ready():
	var pages: DocumentPagesChecker = load(document_pages_scene).instance()
	$MarginContainer/Rows.add_child(pages)
	$MarginContainer/Rows/ToolBar/NextButton.connect("pressed", pages, "_on_NextButton_pressed")
