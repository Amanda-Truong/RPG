extends Node
var type = "caster" 
var maxHP = 0
var currentHP = 0
var att 
var order = 0 
var shield = 0 
var maxShield = 0 
var chanceHit = 23
var casterName = "Caster"
var potency = 100
var skillsApplied = [] 
var subClasses = ["Sorcerer","Warlock", "Arcanist"]
var skillsAvailable = [] 
var player 
var sorcererSkills = [] 
var warlockSkills = [] 
var arcanistSkills = [] 
var alive = true
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
			
			var a = "res://skills/character/caster/sorcerer/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			
			sorcererSkills.append(temp)
			skillsAvailable.append(temp)
	for item in warlockData:
		if(warlockData[item] == "true"): 
			 
			
			var a = "res://skills/character/caster/warlock/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			warlockSkills.append(temp)
			skillsAvailable.append(temp)
	for item in arcanistData:
		if(arcanistData[item] == "true"):
			
			
			var a = "res://skills/character/caster/arcanist/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			
			skillsAvailable.append(temp)
			arcanistSkills.append(temp)

func getSkill(skillName):
	if skillName == "sorcerer":
		return sorcererSkills 
	if skillName == "warlock":
		return warlockSkills
	if skillName == "arcanist":
		return arcanistSkills
func setGear(): 
	maxHP = 240 
	currentHP = 240
	att = 7 
	
func chanceHit(): 
	chanceHit = 23
func attack():
	return potency * (att * 0.1)
func turn(): 
	print("Caster's turn!") 
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
			
func checkSkillsCD():
	for skill in arcanistSkills: 
		if(skill.cd != 0): 
			skill.available = false
			skill.cd = skill.cd - 1
		if(skill.cd == 0): 
			skill.available = true
	for skill in warlockSkills: 
		if(skill.cd != 0): 
			skill.available = false
			skill.cd = skill.cd - 1
		if(skill.cd == 0): 
			skill.available = true
	for skill in sorcererSkills: 
		if(skill.cd != 0): 
			skill.available = false
			skill.cd = skill.cd - 1
		if(skill.cd == 0): 
			skill.available = true
func applySkill(skill): 
	skillsApplied.append(skill)

##########################################################################################################################
##########################################################################################################################
##########################################################################################################################

func hit():
	return potency * att * 0.1 
