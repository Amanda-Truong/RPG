extends Node
var type = "fighter"
var hp 
var att 
var shield 
var chanceHit 
var fighterName 
var potency = 30
var skillsApplied = [] 
var subClasses = ["Paladin", "Dark Knight", "Warrior"]
#specific branch skills available 
var paladinSkills = [] 
var darkKnightSkills = [] 
var warriorSkills = []

# all skills available 
var skillsAvailable = [] 

var f


func _ready():
	setGear()
	chanceHit()
	
	f = File.new()
	f.open("res://saves/fighter/paladin.json", File.READ)
	var json = JSON.parse(f.get_as_text())
	f.close()
	var paladinData = json.result
	
	f = File.new()
	f.open("res://saves/fighter/darkKnight.json", File.READ)
	json = JSON.parse(f.get_as_text())
	f.close()
	var darkKnightData = json.result
	
	f = File.new()
	f.open("res://saves/fighter/warrior.json", File.READ)
	json = JSON.parse(f.get_as_text())
	f.close()
	var warriorData = json.result
	
	skillsAvailable(paladinData, darkKnightData, warriorData)
	
	print(skillsAvailable)
	pass # Replace with function body.

func skillsAvailable(paladinData, darkKnightData, warriorData):
	for item in paladinData:
		if(paladinData[item] == "true"):
			skillsAvailable.append(item)
			var a = "res://skills/character/fighter/paladin/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			
			paladinSkills.append(temp)
	for item in darkKnightData:
		if(darkKnightData[item] == "true"): 
			skillsAvailable.append(item) 
			
			var a = "res://skills/character/fighter/darkKnight/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			darkKnightSkills.append(temp)
			
	for item in warriorData:
		if(warriorData[item] == "true"):
			skillsAvailable.append(item)
			
			var a = "res://skills/character/fighter/warrior/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			
			warriorSkills.append(temp)


func setGear(): 
	hp = 350 
	att = 10 
	
func chanceHit(): 
	chanceHit = 29 
func attack():
	return potency * (att * 0.1)
func getSkills():
	return [paladinSkills, darkKnightSkills, warriorSkills, skillsAvailable]

func getSkill(skillName):
	if skillName == "warrior":
		return warriorSkills 
	if skillName == "paladin":
		return paladinSkills
	if skillName == "dark knight":
		return darkKnightSkills
func turn(): 
	print("Fighter's turn!") 
	var pray = preload("res://skills/character/fighter/paladin/pray.gd")
	var reprisal = preload("res://skills/character/fighter/paladin/reprisal.gd") 
	skillsAvailable = [pray.new(), reprisal.new()]
	
