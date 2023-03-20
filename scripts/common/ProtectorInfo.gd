extends Control

func _ready():
	pass

func set_info(cell):
	$Control/ImageCell/Image.texture = cell.get_image_texture()
	$Control/ProtectorHeader.text = cell.item_name
	$Control/ScrollContainer/VBoxContainer/Description.text = cell.item_description
