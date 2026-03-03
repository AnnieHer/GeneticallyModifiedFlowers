class_name DialogueElement
extends Resource


var interacted: bool = false
var increment: int = 0
@export_multiline var text: Array[String]
@export var condition: String
@export var looping: bool = false

func read() -> String:
	var get_text: String = text[increment]
	increment += 1
	if increment == text.size() and looping:
		increment = 0
	increment = clampi(increment, 0, text.size() - 1)
	return get_text
	
func is_condition_met() -> bool:
	if condition == "":
		return true
	return DialogueConditions.conditions[condition]
