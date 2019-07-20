extends Node

var cd = 0 
var turns = 0
var available = true 
var skillName = "Caustic"
func _ready():
	pass # Replace with function body.

func caustic():
	cd = 10 
	turns = 5 
	return [400,100]