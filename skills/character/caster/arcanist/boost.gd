extends Node

var cd = 0
var turns = 0
var available = true 
var skillName = "Boost" 
func _ready():
	pass # Replace with function body.
func boost():
	cd = 5 
	turns = 1 
	return 1.5 