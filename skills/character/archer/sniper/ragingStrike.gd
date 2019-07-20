extends Node

var cd = 0 
var turns = 0
var available = true 
var skillName = "Raging Strike"
func _ready():
	pass # Replace with function body.

func ragingStrike():
	cd = 8 
	return [600,300] 