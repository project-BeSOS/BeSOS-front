extends Control


func _on_button_kierunki_studenta_pressed():
	SceneChanger.change_scene("res://views/kierunki_studenta.tscn")

func _on_button_oceny_pressed():
	SceneChanger.change_scene("res://views/oceny.tscn")

func _on_button_zaliczenia_pressed():
	SceneChanger.change_scene("res://views/zaliczenia.tscn")

func _on_button_przedmioty_pressed():
	SceneChanger.change_scene("res://views/przedmioty.tscn")
