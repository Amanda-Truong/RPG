extends Node

var cd = 0
var turns = 0
var available = true 
var skillName = "Enrage" 

func _ready():
	pass # Replace with function body.

func enrage():
	cd = 5 
	turns = 1 
	return 2 