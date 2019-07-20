extends Node

var cd = 0
var turns = 0
var available = true 
var skillName = "Full Regen" 

func _ready():
	pass # Replace with function body.

func fullRegen():
	cd = 6 
	turns = 4 
	return 100 