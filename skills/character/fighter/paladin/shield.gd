extends Node

var cd = 0
var turns = 0
var available = true 
var skillName = "Shield" 
func _ready():
	pass # Replace with function body.

func shield():
	cd = 4
	return 1/3