extends HBoxContainer

export var scene_path: String

func _on_Change_Scene_Button_pressed():
	get_tree().change_scene(scene_path)
