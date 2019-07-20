extends Node

var cd = 0
var turns = 0
var available = true 
var skillName = "Vampire" 

func _ready():
	pass # Replace with function body.

func vampire(): 
	turns = 3 
	cd = 9 
	return 1/2 