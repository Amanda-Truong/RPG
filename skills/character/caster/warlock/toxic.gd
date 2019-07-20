extends Node

var cd = 0
var turns = 0
var available = true 
var skillName = "Toxic" 
func _ready():
	pass # Replace with function body.
func toxic():
	cd = 5
	turns = 3
	return 300