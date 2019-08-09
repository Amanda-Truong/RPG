extends Node
var type = "archer"
var maxHP = 0
var currentHP = 0
var att = 7
var order = 0 
var shield = 0
var maxShield = 0
var chanceHit = 25
var archerName  = "Archer"
var potency = 100
var skillsApplied = [] 
var skillsAvailable = [] 
var subClasses = ["Sniper", "Ranger", "Trapper"]
var sniperSkills = [] 
var rangerSkills = [] 
var trapperSkills = [] 
var player
var alive = true
var f 



func _ready():
	setGear()
	chanceHit()
	
	f = File.new()
	f.open("res://saves/archer/sniper.json", File.READ)
	var json = JSON.parse(f.get_as_text())
	f.close()
	var sniperData = json.result
	
	f = File.new()
	f.open("res://saves/archer/ranger.json", File.READ)
	json = JSON.parse(f.get_as_text())
	f.close()
	var rangerData = json.result
	
	f = File.new()
	f.open("res://saves/archer/trapper.json", File.READ)
	json = JSON.parse(f.get_as_text())
	f.close()
	var trapperData = json.result
	
	skillsAvailable(sniperData, rangerData, trapperData)
	
	print(skillsAvailable)
	pass 

func skillsAvailable(sniperData, rangerData, trapperData):
	for item in sniperData:
		if(sniperData[item] == "true"):
			var a = "res://skills/character/archer/sniper/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			
			skillsAvailable.append(temp)
			sniperSkills.append(temp)
	for item in rangerData:
		if(rangerData[item] == "true"): 
			
			var a = "res://skills/character/archer/ranger/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			rangerSkills.append(temp)
			skillsAvailable.append(temp)
	for item in trapperData:
		if(trapperData[item] == "true"):
			
			var a = "res://skills/character/archer/trapper/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			skillsAvailable.append(temp)
			trapperSkills.append(temp)
func getSkill(skillName):
	if skillName == "sniper":
		return sniperSkills
	if skillName == "ranger":
		return rangerSkills
	if skillName == "trapper":
		return trapperSkills
func setGear(): 
	maxHP = 300 
	currentHP = 300
	att = 10 
	
func attack():
	return potency * (att * 0.1)
func chanceHit(): 
	chanceHit = 25
	
func turn(): 
	print("Archer's turn!") 
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
	for skill in sniperSkills: 
		if(skill.cd != 0): 
			skill.available = false
			skill.cd = skill.cd - 1
		if(skill.cd == 0): 
			skill.available = true
	for skill in rangerSkills: 
		if(skill.cd != 0): 
			skill.available = false
			skill.cd = skill.cd - 1
		if(skill.cd == 0): 
			skill.available = true
	for skill in trapperSkills: 
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
