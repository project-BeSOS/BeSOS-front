extends Control

@onready var request = $HTTPRequest
@onready var inputStudent:input = $ColorRect/studentId
@onready var inputSubject:input = $ColorRect/subjectId
@onready var inputGrade:input = $ColorRect/grade
@onready var responseMsgLabel:Label = $"return message"

func _on_confirm_button_pressed():
	#walidacja
	if inputStudent.is_empty() || inputSubject.is_empty() || inputGrade.is_empty():
		responseMsgLabel.text = "uzupełnij wszystkie pola"
		return 
	
	var url:String = Globals.backend_url
	url += "student/"
	url += str(inputStudent.get_data())
	url += "/przedmiot/"
	url += str(inputSubject.get_data())
	url += "/wystawiajacy/"
	url += str(Globals.hardcodedTeacher)
	url += "/ocena/"
	url += str(inputGrade.get_data())
	print("wysłane URL:"+url)
	request.request(url, [], HTTPClient.METHOD_POST)


func _on_http_request_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	print("result:"+str(result))
	print("response_code:"+str(response_code))
	var err = json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	print("body:"+str(response))
	
	if response_code == 400 || response_code == 404:
		responseMsgLabel.text = response.get("error")
	elif response_code == 201:
		responseMsgLabel.text = response.get("message")
	else:
		responseMsgLabel.text = "nieznany błąd"

func _on_return_button_pressed():
	SceneChanger.change_scene("res://views/main_menu.tscn")
