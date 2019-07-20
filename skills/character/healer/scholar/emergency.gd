extends Node

var cd = 0
var turns = 0
var available = true 
var skillName = "Emegency" 

func _ready():
	pass # Replace with function body.
func emergency():
	cd = 5 
	return [100,200]