extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var maximumHP = 240 
var currentHP = 240 
var att = 7 
var dead
var turnsTaken = 0
var turn = 0 
var healerName
var chanceHit = 23
var potency = 30

var branchOne = "priest" 
var branchTwo = "scholar" 
var brachThree = "cleric" 
var cureCD = 0
var galvanizeCD = 0
var regenCD = 0 
var regen = 0 

var cureWho 

var galvanizeWho 
var galvanizeChar

var regenWho
var regenChar
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("ready",self,"get_name")
	setName()
	pass # Replace with function body.

func get_name(): 
		return "healer" 
		

func get_action(): 
	print("healer action")

func attack():
	return potency * (att * 0.1)
func cure():
	cureCD = 2 
	return 100 * (att * 0.2)
func galvanize():
	galvanizeCD = 2 
	return 100 * (att * 0.2) 
func regen():
	print("@@@@@@@@@@@@@@@@ Calling REGEN! @@@@@@@@@@@@@")
	return 50 * (att * 0.2)
func setName():
	var f = File.new()
	f.open("res://sprites/healer/data/healerData.json", File.READ)
	var json = JSON.parse(f.get_as_text())
	f.close()
	var data = json.result
	# Modify
	healerName = data["name"] 