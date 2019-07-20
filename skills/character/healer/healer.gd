extends Node
var type = "healer"
var hp 
var att = 7
var shield 
var chanceHit 
var healerName 
var potency = 20
var skillsApplied = [] 
var subClasses = ["Priest", "Scholar", "Cleric"] 
var priestSkills = [] 
var scholarSkills = [] 
var clericSkills = [] 

var skillsAvailable = [] 

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
			skillsAvailable.append(item)
			var a = "res://skills/character/healer/priest/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			
			priestSkills.append(temp)
	for item in scholarData:
		if(scholarData[item] == "true"): 
			skillsAvailable.append(item) 
			
			var a = "res://skills/character/healer/scholar/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			scholarSkills.append(temp)
			
	for item in clericData:
		if(clericData[item] == "true"):
			skillsAvailable.append(item)
			
			var a = "res://skills/character/healer/cleric/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			
			clericSkills.append(temp)

func getSkill(skillName):
	if skillName == "priest":
		return priestSkills
	if skillName == "cleric":
		return clericSkills 
	if skillName == "scholar":
		return scholarSkills

func setGear(): 
	hp = 240
	att = 10 
	
func chanceHit(): 
	chanceHit = 23
	
func turn(): 
	print("Healer's turn!") 