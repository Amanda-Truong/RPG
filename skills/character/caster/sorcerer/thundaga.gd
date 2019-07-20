extends Node

var cd = 0
var turns = 0
var available = true 
var skillName = "Thundaga" 
func _ready():
	pass # Replace with function body.

func thundaga():
	cd = 7 
	turns = 3 
	return [700, 150]