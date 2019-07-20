extends Node

var hp 
var att 
var shield  
var bossName 

var skillsApplied = [] 
var skillsAvailable = [] 
func _ready():
	setGear()
	pass # Replace with function body.

func setGear(): 
	hp = 3500 
	att = 10 
	

func turn(): 
	print("Tree's turns!") 