extends Node

var cd = 0 
var turns = 0
var available = true 
var skillName = "Straight Shot"
func _ready():
	pass # Replace with function body.

func straightShot():
	cd = 4 
	return [300, 200, 100] 