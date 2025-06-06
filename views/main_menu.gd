extends Control

func _ready():
	$currentStudentId.text = "student "+str(Globals.idStudenta)
	#warm up besos
	$HTTPRequest.request("https://besos.bieda.it/student/100002/kierunki")

func _on_button_kierunki_studenta_pressed():
	SceneChanger.change_scene("res://views/kierunki_studenta.tscn")

func _on_button_oceny_pressed():
	SceneChanger.change_scene("res://views/oceny.tscn")

func _on_button_zaliczenia_pressed():
	SceneChanger.change_scene("res://views/zaliczenia.tscn")

func _on_button_przedmioty_pressed():
	SceneChanger.change_scene("res://views/przedmioty.tscn")

func _on_button_change_student_pressed():
	SceneChanger.change_scene("res://views/change_student.tscn")

func _on_button_dodaj_ocene_pressed():
	SceneChanger.change_scene("res://views/form dodajOcene.tscn")

func _on_button_dodaj_zaliczenie_pressed():
	SceneChanger.change_scene("res://views/form_dodaj_zaliczenie.tscn")
