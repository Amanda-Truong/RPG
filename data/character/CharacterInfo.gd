extends Node

var casterName 
var fighterName 
var healerName 
var archerName 
var level 
var skillPoints


class_name CharacterInfo
func _ready():
	
	pass # Replace with function body.

func characterNames(): 
	var f = File.new()
	f.open("res://saves/save.json", File.READ)
	var json = JSON.parse(f.get_as_text())
	f.close()
	var data = json.result
	print("haha")
	casterName = data["casterName"] 
	fighterName = data["fighterName"]
	archerName = data["archerName"] 
	healerName = data["healerName"]  
	level = data["level"] 
	skillPoints = data["skillPoints"] 

