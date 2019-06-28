extends Sprite

var archerName
var maximumHP = 300 
var currentHP = 300
var att = 10 
var dead
var turnsTaken 
var turn = 0 
var chanceHit = 25
var potency = 100
var poisonArrowCD = 0
var poisonArrow = 0
var powerShotICD = 0
var barrageICD = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("ready",self,"get_name")
	setName()
	pass # Replace with function body.

func get_name(): 
		return "archer" 
		
func attack():
	return potency * (att * 0.1)

func powerShotI():
	powerShotICD = 3
	return 300 * (att * 0.1) 

func barrageI():
	barrageICD = 3
	return 200 * (att * 0.1)
func poisonArrow():
	return 100 * (att * 0.1)
func setName():
	var f = File.new()
	f.open("res://sprites/archer/data/archerData.json", File.READ)
	var json = JSON.parse(f.get_as_text())
	f.close()
	var data = json.result
	# Modify
	archerName = data["name"] 