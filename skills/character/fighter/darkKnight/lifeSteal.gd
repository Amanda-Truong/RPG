extends Node

var cd = 0
var turns = 0
var available = true 
var skillName = "Life Steal" 
func _ready():
	pass # Replace with function body.

func lifeSteal(): 
	cd = 3 
	return [100, 1/4] 