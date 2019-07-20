extends Node

var cd = 0 
var turns = 0
var available = true 
var skillName = "Strengthen" 

func _ready():
	pass # Replace with function body.

func strengthen():
	cd = 7 
	turns = 1
	return 1.5 
	
