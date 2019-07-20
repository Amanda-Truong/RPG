extends Node

var cd = 0
var turns = 0
var available = true 
var skillName = "Poison" 
func _ready():
	pass # Replace with function body.
func poison():
	cd = 3 
	turns = 3
	return 100