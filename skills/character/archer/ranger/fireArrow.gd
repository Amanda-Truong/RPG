extends Node

var cd = 0 
var turns = 0
var available = true 
var skillName = "Fire Arrow"
func _ready():
	pass # Replace with function body.

func fireArrow():
	cd = 6 
	turns = 3
	return [300, 100]