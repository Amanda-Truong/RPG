extends Node

var cd = 0
var turns = 0
var available = true 
var skillName = "Disease" 

func _ready():
	pass # Replace with function body.
func disease():
	cd= 5 
	turns = 3 
	return [100,50]