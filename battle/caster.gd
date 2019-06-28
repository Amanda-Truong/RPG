extends Sprite

var maximumHP = 240
var currentHP = 240 
var att = 7 

var turnsTaken 
var turn = 0 
var chanceHit = 23
var potency = 100 

var fire = 0
var fireCD = 0
var casterName
var silence = 0
var silenceCD = 0
var silenceWho
var dead
var charge = 0
var chargeCD = 0
var chargeWho 
var chargeChar 

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("ready",self,"get_name")
	setName()
	pass # Replace with function body.

func get_name(): 
		return "caster" 
		

func attack():
	return potency * (att * 0.1)

func fire():
	fireCD = 2
	return 400 * (att * 0.1) 


func silence():
	silenceWho = true
	silenceCD = 6 
	silence = 1
func setName():
	var f = File.new()
	f.open("res://sprites/caster/data/casterData.json", File.READ)
	var json = JSON.parse(f.get_as_text())
	f.close()
	var data = json.result
	# Modify
	casterName = data["name"] 
func charge():
	return 1.2