extends Node

var cd = 0
var turns = 0
var available = true 
var skillName = "Leech" 
func _ready():
	pass # Replace with function body.
func leech():
	cd = 5 
	return [600, 1/3]