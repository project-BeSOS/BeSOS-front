extends progPanel

var studentIndex:int = 0

func _on_button_pressed():
	Globals.idStudenta = studentIndex
	SceneChanger.change_scene("res://views/main_menu.tscn")
