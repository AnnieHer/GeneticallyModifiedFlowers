extends Node2D


var conditions: Dictionary[String, bool] = {
	"Mirror_centered": false,
	"Mirror_not_centered": true,
}


func set_condition(condition_name: String, value: bool):
	conditions[condition_name] = value
	
	
func get_condition(condition_name: String) -> bool:
	return conditions[condition_name]
