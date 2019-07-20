extends Node

var cd = 0 
var turns = 0
var available = true 
var skillName = "Send Off"
func _ready():
	pass # Replace with function body.

func sendOff():
	cd = 6 
	return [500,400] 