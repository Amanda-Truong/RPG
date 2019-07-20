extends Node

var cd = 0 
var turns = 0
var available = true 
var skillName = "Bleed"
func _ready():
	pass # Replace with function body.
func bleed():
	cd = 9 
	turns = 3 
	return [300,200]