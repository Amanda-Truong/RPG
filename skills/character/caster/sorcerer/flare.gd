extends Node

var cd = 0
var turns = 0
var available = true 
var skillName = "Flare" 
func _ready():
	pass # Replace with function body.
func flare():
	cd = 8 
	turns = 2 
	return [900, 100] 