extends View

@onready var container = $ScrollContainer/VBoxContainer
@onready var request = $HTTPRequest
@onready var panel = preload("res://panels/panel_oceny.tscn")
@onready var errorLabel = $errorLabel
@onready var loading = $loading

func _ready():
	await get_tree().create_timer(1).timeout
	request.request(Globals.backend_url+"/student/"+str(100005)+"/oceny", [], HTTPClient.METHOD_GET)



func _on_http_request_request_completed(_result, _response_code, _headers, body):
	#print("completed")
	var json = JSON.new()
	var err = json.parse(body.get_string_from_utf8())
	#error proofing i guess
	if typeof(err) == TYPE_NIL:
		await get_tree().create_timer(1).timeout
		request.request(Globals.backend_url+"/student/"+str(100005)+"/oceny", [], HTTPClient.METHOD_GET)
		print("error, ponowne wysylanie zapytania")
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
	
	for k:Dictionary in response["oceny"]:
		var newPanel:progPanel = panel.instantiate()
		newPanel.set_label_text("nazwa", str(k.get("przedmiot")))
		newPanel.set_label_text("opiekun", str(k.get("opiekun przedmiotu")))
		newPanel.set_label_text("data", str(k.get("data-wystawienia")))
		newPanel.set_label_text("ocena", str(k.get("ocena")))
		container.add_child(newPanel)


func _on_return_button_pressed():
	SceneChanger.change_scene("res://views/main_menu.tscn")
