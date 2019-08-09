extends Node
var type = "fighter"
var maxHP = 0
var currentHP = 0
var att = 70
var shield = 0
var maxShield = 0 
var counter 
var order = 0 
var chanceHit = 29
var fighterName = "Fighter"
var potency = 1000
var skillsApplied = [] 
var subClasses = ["Paladin", "Dark Knight", "Warrior"]
var paladinSkills = [] 
var darkKnightSkills = [] 
var warriorSkills = []
var player 
var skillsAvailable = [] 
var alive = true
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
			
			var a = "res://skills/character/fighter/paladin/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			
			paladinSkills.append(temp)
			skillsAvailable.append(temp)
	for item in darkKnightData:
		if(darkKnightData[item] == "true"): 
			
			var a = "res://skills/character/fighter/darkKnight/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			darkKnightSkills.append(temp)
			skillsAvailable.append(temp)
	for item in warriorData:
		if(warriorData[item] == "true"):
			
			var a = "res://skills/character/fighter/warrior/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			
			warriorSkills.append(temp)
			skillsAvailable.append(temp)

func setGear(): 
	maxHP = 350 
	currentHP = 350
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
	checkSkillsApplied()
	checkSkillsCD()

func checkSkillsApplied():
	for skill in skillsApplied: 
		if(skill.turns != 0): 
			skill.turns = skill.turns - 1 
			skill.skillProcess(player)
		if(skill.cd == 0): 
			var i = skillsApplied.find(skill)
			skillsApplied.remove(i)
			skill.skillReset(player)

func applySkill(skill): 
	skillsApplied.append(skill)
	
func checkSkillsCD():
	for skill in paladinSkills: 
		if(skill.cd != 0): 
			skill.available = false
			skill.cd = skill.cd - 1
		if(skill.cd == 0): 
			skill.available = true
	for skill in warriorSkills: 
		if(skill.cd != 0): 
			skill.available = false
			skill.cd = skill.cd - 1
		if(skill.cd == 0): 
			skill.available = true
	for skill in darkKnightSkills: 
		if(skill.cd != 0): 
			skill.available = false
			skill.cd = skill.cd - 1
		if(skill.cd == 0): 
			skill.available = true

##########################################################################################################################
##########################################################################################################################
##########################################################################################################################

func hit():
	return potency * att * 0.1 
