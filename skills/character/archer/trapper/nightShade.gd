extends Node

var cd = 0 
var turns = 0
var available = true 
var skillName = "Night Shade"
func _ready():
	pass # Replace with function body.

func nightShade():
	cd = 10 
	turns = 4
	return [300,100]