extends Node

var cd = 0
var turns = 0
var available = true 
var skillName = "Haste" 
func _ready():
	pass # Replace with function body.
func haste():
	cd = 10
	return 2