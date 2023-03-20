extends Control
class_name ImageCell

export var image: Texture
export var bg_color: Color = Color.white
export var frame_color: Color = Color.red
export var clickable: bool = false
export var index: int = -1
export var choosen: bool = false
export var item_name: String = "Предмет"
export(String, MULTILINE) var item_description = "Описание предмета"

signal on_image_cell_click(cell)
signal on_image_cell_info_click(cell)

func _ready():
	$Image.texture = image
	$BG.color = bg_color
	$Frame.color = frame_color
	$Frame.hide()

func get_image_texture():
	return $Image.texture
	
func connect_signals(target):
	connect("on_image_cell_click", target, "_create_cell")
	connect("on_image_cell_info_click", target, "_set_clicked_item_info")

func init_cell(cell):
	item_name = cell.item_name
	item_description = cell.item_description
	image = cell.image
	bg_color = cell.bg_color
	frame_color = cell.frame_color
	index = cell.index
	choosen = not cell.choosen
	clickable = true

func update_texture():
	pass

func _on_TextureRect_gui_input(event):
	if not clickable:
		return
	if event.is_action_pressed("ui_click"):
		print("[image cell] clicked on #%s cell" % index)
		emit_signal("on_image_cell_click", self)
	if event.is_action_pressed("ui_info_click"):
		print("[image cell] getting ingo of cell")
		emit_signal("on_image_cell_info_click", self)


func _on_Image_mouse_entered():
	if clickable:
		$Frame.show()


func _on_Image_mouse_exited():
	if clickable:
		$Frame.hide()
