extends Node
var type = "caster" 
var hp 
var att 
var shield 
var chanceHit 
var casterName 
var potency = 100
var skillsApplied = [] 
var subClasses = ["Sorcerer","Warlock", "Arcanist"]
var skillsAvailable = [] 

var sorcererSkills = [] 
var warlockSkills = [] 
var arcanistSkills = [] 

var f 

func _ready():
	setGear()
	chanceHit()
	
	f = File.new()
	f.open("res://saves/caster/sorcerer.json", File.READ)
	var json = JSON.parse(f.get_as_text())
	f.close()
	var sorcererData = json.result
	
	f = File.new()
	f.open("res://saves/caster/warlock.json", File.READ)
	json = JSON.parse(f.get_as_text())
	f.close()
	var warlockData = json.result
	
	f = File.new()
	f.open("res://saves/caster/arcanist.json", File.READ)
	json = JSON.parse(f.get_as_text())
	f.close()
	var arcanistData = json.result
	
	skillsAvailable(sorcererData, warlockData, arcanistData)
	
	print(skillsAvailable)
	pass 

func skillsAvailable(sorcererData, warlockData, arcanistData):
	for item in sorcererData:
		if(sorcererData[item] == "true"):
			skillsAvailable.append(item)
			var a = "res://skills/character/caster/sorcerer/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			
			sorcererSkills.append(temp)
	for item in warlockData:
		if(warlockData[item] == "true"): 
			skillsAvailable.append(item) 
			
			var a = "res://skills/character/caster/warlock/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			warlockSkills.append(temp)
			
	for item in arcanistData:
		if(arcanistData[item] == "true"):
			skillsAvailable.append(item)
			
			var a = "res://skills/character/caster/arcanist/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			
			arcanistSkills.append(temp)

func getSkill(skillName):
	if skillName == "sorcerer":
		return sorcererSkills 
	if skillName == "warlock":
		return warlockSkills
	if skillName == "arcanist":
		return arcanistSkills
func setGear(): 
	hp = 240 
	att = 7 
	
func chanceHit(): 
	chanceHit = 23
func attack():
	return potency * (att * 0.1)
func turn(): 
	print("Caster's turn!") 