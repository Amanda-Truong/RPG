extends Node

var cd = 0 
var turns = 0
var available = true 
var skillName = "Blood Arrow"
func _ready():
	pass # Replace with function body.
func bloodArrow():
	cd = 8 
	turns = 4 
	return [300,100]
