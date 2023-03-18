extends ColorRect
class_name WrongMarker

signal marked_event(data)

var marked: bool = false

export var index: int = -1
export var idle_color: Color
export var mistake_color: Color

func _ready():
	change_marked_state(marked)


func _on_marker_gui_event(event: InputEvent):
	if event.is_action_pressed("ui_click"):
		change_marked_state(not marked)
		emit_signal("marked_event", {"index": index, "marked": marked})


func change_marked_state(has_mistake: bool):
	print('[marker] %s changing state' % index)
	marked = has_mistake
	color = mistake_color if marked else idle_color
