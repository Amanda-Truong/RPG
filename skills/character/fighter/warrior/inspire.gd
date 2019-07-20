extends Node

var cd = 0
var turns = 0
var available = true 
var skillName = "Inspire"
func _ready():
	pass # Replace with function body.

func inspire():
	turns = 3 
	cd = 5 
	return 1/4 