extends Node

var cd = 0
var turns = 0
var available = true 
var skillName = "Soulter" 


func _ready():
	pass # Replace with function body.

func soulter():
	cd = 1 
	return [(100 * (1/5 * 0.01)), 1/5]  