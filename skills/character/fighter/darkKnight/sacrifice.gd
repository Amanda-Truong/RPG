extends Node

var cd = 0
var turns = 0
var available = true 
var skillName = "Sacrifice" 
func _ready():
	pass # Replace with function body.

func sacrifice(): 
	cd = 3 
	return [100, 1/4] 