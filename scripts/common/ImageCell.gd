extends ColorRect
class_name ImageCell

export var image: Texture
export var bg_color: Color
export var clickable: bool = false
export var index: int = -1
export var choosen: bool = false

signal on_image_cell_click(cell)

func _ready():
	$TextureRect.texture = image
	color = bg_color
	
func connect_signals(target):
	connect("on_image_cell_click", target, "_create_cell")

func init_cell(cell):
	image = cell.image
	color = cell.bg_color
	index = cell.index
	choosen = not cell.choosen
	clickable = true

func _on_TextureRect_gui_input(event):
	if event.is_action_pressed("ui_click") and clickable:
		print("[image cell] clicked on #%s cell" % index)
		emit_signal("on_image_cell_click", self)
