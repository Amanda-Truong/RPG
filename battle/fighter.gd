extends Sprite

var maximumHP = 350 
var currentHP = 350
var att = 10
var dead
var fighterName 
var dict = {}
var turnsTaken 
var turn = 1 
var chanceHit = 29
var potency = 30


var tauntCD = 0
var counterCD = 0 
var shelterCD = 0 

var taunt = 0
var counter = 0

var shelterWho 
var shelterChar 

func _ready():
	connect("ready",self,"get_name")
	setName()
	pass # Replace with function body.
func taunt():
	tauntCD = 5
	chanceHit = 90 
	taunt = 3 

func counter(): 
	counterCD = 2
	counter = 1

func shelter(): 
	return currentHP / 3

func attack():
	return potency * (att * 0.1)

func get_name(): 
	return "fighter"
	
func setName():
	var f = File.new()
	f.open("res://sprites/fighter/data/fighterData.json", File.READ)
	var json = JSON.parse(f.get_as_text())
	f.close()
	var data = json.result
	# Modify
	fighterName = data["name"] 
	