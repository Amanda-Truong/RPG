extends Node
var type = "archer"
var hp 
var att 
var shield 
var chanceHit 
var archerName  
var potency = 100
var skillsApplied = [] 
var skillsAvailable = [] 
var subClasses = ["Sniper", "Ranger", "Trapper"]
var sniperSkills = [] 
var rangerSkills = [] 
var trapperSkills = [] 

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
			skillsAvailable.append(item)
			var a = "res://skills/character/archer/sniper/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			
			sniperSkills.append(temp)
	for item in rangerData:
		if(rangerData[item] == "true"): 
			skillsAvailable.append(item) 
			
			var a = "res://skills/character/archer/ranger/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			rangerSkills.append(temp)
			
	for item in trapperData:
		if(trapperData[item] == "true"):
			skillsAvailable.append(item)
			
			var a = "res://skills/character/archer/trapper/" + str(item) + ".gd"
			a = str(a)
			var temp = load(a).new()
			
			trapperSkills.append(temp)
func getSkill(skillName):
	if skillName == "sniper":
		return sniperSkills
	if skillName == "ranger":
		return rangerSkills
	if skillName == "trapper":
		return trapperSkills
func setGear(): 
	hp = 300 
	att = 10 
	
func attack():
	return potency * (att * 0.1)
func chanceHit(): 
	chanceHit = 25
	
func turn(): 
	print("Archer's turn!") 