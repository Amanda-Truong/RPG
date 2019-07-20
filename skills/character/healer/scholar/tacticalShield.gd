extends Node

var cd = 0
var turns = 0
var available = true 
var skillName = "Tactical Shield" 

func _ready():
	pass # Replace with function body.
func tacticalShield():
	cd = 5 
	return [100,500]