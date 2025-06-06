extends LineEdit
class_name input

enum inputTypeEnum {
	INT,
	STRING,
	FLOAT,
	DATE
}

@export var type:inputTypeEnum = inputTypeEnum.STRING

func is_empty() -> bool:
	if text.length() == 0:
		return true
	return false

func get_data():
	match type:
		inputTypeEnum.INT:
			return int(text)
		inputTypeEnum.STRING:
			return str(text)
		inputTypeEnum.FLOAT:
			return float(text)
