extends Control

var cell_node = preload("res://scenes/common/ImageCell.tscn")
onready var cell_container = $ProtectorsHeader/AvailableProtectorsList/GridContainer
onready var choosen_container = $ChoosedProtectorsHeader/ChoosedProtectorsList/GridContainer

func _ready():
	var cell_container = $ProtectorsHeader/AvailableProtectorsList/GridContainer
	for child in cell_container.get_children():
		var c: ImageCell = (child as ImageCell)
		c.connect_signals(self)
		
func _create_cell(cell):
	print("[protection step] choosing cell")
	var new_cell = cell_node.instance()
	new_cell.init_cell(cell)
	new_cell.connect_signals(self)
	if not cell.choosen:
		choosen_container.add_child(new_cell)
		choosen_container.move_child(new_cell, 0)
	else:
		cell_container.add_child(new_cell)
		cell_container.move_child(new_cell, 0)
	cell.queue_free()

func _delete_from_choosen(cell):
	for child in cell_container.get_children():
		if cell.index == child.index:
			var c = (child as Node)
			c.free()
