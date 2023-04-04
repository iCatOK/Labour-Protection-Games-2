extends Control

# Contains global methods for whole scene
# Like: escape scene handling

onready var visual_novel_button = $"Content/Vertical Aligment/VisualNovelMode/Button"

func _ready():
	OS.set_window_maximized(true)
	set_visual_novel_button_text()

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		# close the game, if Esc is pressed
		get_tree().quit()

func _on_Change_Scene_Button_pressed():
	pass # Replace with function body.
	
func _on_Visual_Novel_Mode_Button_pressed():
	Global.is_visual_novel = not Global.is_visual_novel
	set_visual_novel_button_text()

func set_visual_novel_button_text():
	visual_novel_button.text = "Режим: визуальная новелла" \
	if Global.is_visual_novel else "Режим: тест" 
