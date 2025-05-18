extends View

@onready var container = $ScrollContainer/VBoxContainer
@onready var request = $HTTPRequest
@onready var panel = preload("res://panels/panel_kierunki_studenta.tscn")
@onready var errorLabel = $errorLabel

func _ready():
	#var body = JSON.stringify({"student_id":"100001"})
	request.request(Globals.backend_url+"kierunkiStudenta?student_id="+str(100001), [], HTTPClient.METHOD_GET)



func _on_http_request_request_completed(result, response_code, _headers, body):
	var json = JSON.new()
	var err = json.parse(body.get_string_from_utf8())
	var response:Dictionary = json.get_data()

	if err != OK:
		print("error")
		errorLabel.show()
		errorLabel.text += str("blad parsowania json")
		return
	if response.has("error"):
		errorLabel.show()
		errorLabel.text += str(response["error"])
		return
	
	for k:Dictionary in response["kierunki"]:
		var newPanel:progPanel = panel.instantiate()
		newPanel.set_label_text("nazwa", str(k.get("nazwa")))
		newPanel.set_label_text("semestr", str(k.get("obecny_semestr")))
		newPanel.set_label_text("rok rozpoczecia", str(k.get("rok_rozpoczecia")))
		newPanel.set_label_text("rok zakonczenia", str(k.get("rok_ukonczenia")))
		container.add_child(newPanel)
