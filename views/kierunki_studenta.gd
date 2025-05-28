extends View

@onready var container = $ScrollContainer/VBoxContainer
@onready var request = $HTTPRequest
@onready var panel = preload("res://panels/panel_kierunki_studenta.tscn")
@onready var errorLabel = $errorLabel
@onready var loading = $loading

func _ready():
	#var body = JSON.stringify({"student_id":"100001"})
	await get_tree().create_timer(1).timeout
	request.request(Globals.backend_url+"/student/"+str(Globals.idStudenta)+"/kierunki", [], HTTPClient.METHOD_GET)

func _on_http_request_request_completed(_result, _response_code, _headers, body):
	var json = JSON.new()
	var err = json.parse(body.get_string_from_utf8())
	#error proofing i guess
	if typeof(err) == TYPE_NIL:
		await get_tree().create_timer(1).timeout
		request.request(Globals.backend_url+"kierunkiStudenta?student_id="+str(Globals.idStudenta), [], HTTPClient.METHOD_GET)
		return
	var response:Dictionary = json.get_data()
	
	loading.visible = false

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
		newPanel.set_label_text("semestr", str(int(k.get("obecny_semestr"))))
		newPanel.set_label_text("rok rozpoczecia", str(int(k.get("rok_rozpoczecia"))))
		newPanel.set_label_text("rok zakonczenia", str(int(k.get("rok_ukonczenia"))))
		container.add_child(newPanel)


func _on_return_button_pressed():
	SceneChanger.change_scene("res://views/main_menu.tscn")
