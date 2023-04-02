extends HBoxContainer

export var scene_path: String
export var json_config_path: String

func _on_Change_Scene_Button_pressed():
	if (json_config_path):
		print("[scene button] uploading config from %s" % json_config_path)
		Global.init_config(json_config_path)
		print("[scene button] scenario '%s' uploaded" % Global.config.scenario_name)
	get_tree().change_scene(scene_path)
