extends Control
class_name progPanel

func _ready():
	custom_minimum_size = size

func set_label_text(nodeName:String, value:String):
	var label:Label = find_child(nodeName)
	if label != null:
		label.text = value
