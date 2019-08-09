extends Node
var type = "healer"
var maxHP = 0
var currentHP = 0
var att = 7
var shield = 0
var maxShield = 0 
var order = 0 
var chanceHit = 23
var healerName = "Healer"
var potency = 20
var skillsApplied = [] 
var subClasses = ["Priest", "Scholar", "Cleric"] 
var priestSkills = [] 
var scholarSkills = [] 
var clericSkills = [] 
var player
var skillsAvailable = [] 
var alive = true 
var f 

func attack():
	return potency * (att * 0.1) 


func _ready():
	setGear()
	chanceHit()
	
	f = File.new()
	f.open("res://saves/healer/priest.json", File.READ)
	var json = JSON.parse(f.get_as_text())
	f.close()
	var priestData = json.result
	
	f = File.new()
	f.open("res://saves/healer/scholar.json", File.READ)
	json = JSON.parse(f.get_as_text())
	f.close()
	var scholarData = json.result
	
	f = File.new()
	f.open("res://saves/healer/cleric.json", File.READ)
	json = JSON.parse(f.get_as_text())
	f.close()
	var clericData = json.result
	
	skillsAvailable(priestData, scholarData, clericData)
	
	print(skillsAvailable)
	pass # Replace with function body.

func skillsAvailable(priestData, scholarData, clericData):
	for item in priestData:
		if(priestData[item] == "true"):
			var a = "res://skills/character/healer/priest/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			skillsAvailable.append(temp)
			priestSkills.append(temp)
	for item in scholarData:
		if(scholarData[item] == "true"): 

			
			var a = "res://skills/character/healer/scholar/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			scholarSkills.append(temp)
			skillsAvailable.append(temp)
	for item in clericData:
		if(clericData[item] == "true"):
			
			var a = "res://skills/character/healer/cleric/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			
			clericSkills.append(temp)
			skillsAvailable.append(temp)

func getSkill(skillName):
	if skillName == "priest":
		return priestSkills
	if skillName == "cleric":
		return clericSkills 
	if skillName == "scholar":
		return scholarSkills

func setGear(): 
	maxHP = 240
	currentHP = 240
	att = 10 
	
func chanceHit(): 
	chanceHit = 23
	
func turn(): 
	print("Healer's turn!") 
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
	for skill in scholarSkills: 
		if(skill.cd != 0): 
			skill.available = false
			skill.cd = skill.cd - 1
		if(skill.cd == 0): 
			skill.available = true
	for skill in priestSkills: 
		if(skill.cd != 0): 
			skill.available = false
			skill.cd = skill.cd - 1
		if(skill.cd == 0): 
			skill.available = true
	for skill in clericSkills: 
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
