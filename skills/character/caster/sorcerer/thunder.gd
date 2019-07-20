extends Node

var cd = 0
var turns = 0
var available = true 
var skillName = "Thunder" 
func _ready():
	pass # Replace with function body.
func thunder():
	cd = 5
	turns = 3 
	return [300, 50]