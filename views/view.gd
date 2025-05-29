extends Control
class_name  View

@export var useDefaultLogic:bool = true
@export var endpoint:String = ""
@export var defaultPanel:PackedScene = null
@export var translationTable:Dictionary[String, String]
@export var responseArrayName:String = ""

var defaultLoading:Node2D
var defaultRequest:HTTPRequest
var defaultErrorLabel:Label
var defaultContainer:VBoxContainer

func _ready():
	if useDefaultLogic:
		#walidacja
		defaultRequest = find_child("HTTPRequest")
		if defaultRequest == null:
			print("nie znaleziono HTTPRequest")
			return
		defaultLoading = find_child("loading")
		if defaultLoading == null:
			print("nie znaleziono loading")
			return
		defaultErrorLabel = find_child("errorLabel")
		if defaultErrorLabel == null:
			print("nie znaleziono errorLabel")
			return
		defaultContainer = find_child("VBoxContainer")
		if defaultContainer == null:
			print("nie znaleziono VBoxContainer")
			return
		var defaultExit:Button = find_child("return button")
		if defaultExit == null:
			print("nie znaleziono exit")
			return
		else:
			defaultExit.pressed.connect(default_exit)
		
		
		await get_tree().create_timer(1).timeout
		#request
		defaultRequest.request_completed.connect(default_request_callback)
		defaultRequest.request(Globals.backend_url+"/student/"+str(Globals.idStudenta)+"/"+endpoint, [], HTTPClient.METHOD_GET)
	pass

func default_exit():
	SceneChanger.change_scene("res://views/main_menu.tscn")

func default_request_callback(_result, _response_code, _headers, body):
	var json = JSON.new()
	var err = json.parse(body.get_string_from_utf8())
	#error proofing i guess
	if err == null:
		await get_tree().create_timer(1).timeout
		defaultRequest.request(Globals.backend_url+"/student/"+str(Globals.idStudenta)+"/"+endpoint, [], HTTPClient.METHOD_GET)
		print("error, ponowne wysylanie zapytania")
		return
	var response:Dictionary = json.get_data()
	
	defaultLoading.visible = false
	
	if err != OK:
		print("error")
		defaultErrorLabel.show()
		defaultErrorLabel.text += str("blad parsowania json")
		return
	if response.has("error"):
		defaultErrorLabel.show()
		defaultErrorLabel.text += str(response["error"])
		return
	
	for element in response[responseArrayName]:
		var newPanel:progPanel = defaultPanel.instantiate()
		for key in translationTable.keys():
			newPanel.set_label_text(key,str(element.get(translationTable.get(key))))
		defaultContainer.add_child(newPanel)
	#for k:Dictionary in response["oceny"]:
		#var newPanel:progPanel = panel.instantiate()
		#newPanel.set_label_text("nazwa", str(k.get("przedmiot")))
		#newPanel.set_label_text("opiekun", str(k.get("opiekun przedmiotu")))
		#newPanel.set_label_text("data", str(k.get("data-wystawienia")))
		#newPanel.set_label_text("ocena", str(k.get("ocena")))
		#container.add_child(newPanel)
