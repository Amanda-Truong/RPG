extends Node

var cd = 0 
var turns = 0
var available = true 
var skillName = "Poison Arrow"
func _ready():
	pass # Replace with function body.

func poisonArrow():
	cd = 8 
	turns = 4
	return 100 