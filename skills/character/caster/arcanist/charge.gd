extends Node

var cd = 0
var turns = 0
var available = true 
var skillName = "Charge" 
func _ready():
	pass # Replace with function body.
func charge():
	cd = 4 
	turns = 1 
	return 1.2 