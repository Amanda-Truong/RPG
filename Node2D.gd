extends Node2D
var charName = ""
var archer 
var fighter 
var caster 
var healer 
func _ready():
	$nextButton.connect("pressed",self,"Next")
	$TextEdit.connect("text_changed",self,"textChanged")
	archer = $archer
	healer = $healer
	caster = $caster
	$fighter.show()
	fighter = true
	caster = false 
	healer = false 
	archer = false
	pass 

func _on_nextButton_pressed():
	print("WHY")
	
func _on_TextEdit_text_changed(new_text):
	 print("Text changed!")
	 print($TextEdit.text)
	 charName = $TextEdit.text
	 print(charName)
	 
func textChanged():
	charName = $TextEdit.text
	print(charName)
	
func Next(): 
	print(charName, " CHARACTER NAME")
	print(fighter , " FIGHTER ")
	print(archer, " ARCHER") 
	print(caster, " CASTeR") 
	print(healer, " HEALER") 
	if fighter == true:
		$fighter.hide()
		$archer.show()
		
		var f = File.new()
		f.open("res://sprites/fighter/data/fighterData.json", File.READ)
		var json = JSON.parse(f.get_as_text())
		f.close()
		var data = json.result
		# Modify
		print(charName, " CHARACTER NAME")
		data["name"] = charName
		# Save
		f = File.new()
		f.open("res://sprites/fighter/data/fighterData.json", File.WRITE)
		f.store_string(JSON.print(data, "  ", true))
		f.close()
		charName = ""
		fighter = false 
		archer = true
	elif archer == true:
		$archer.hide()
		$caster.show()
		
		
		var f = File.new()
		f.open("res://sprites/archer/data/archerData.json", File.READ)
		var json = JSON.parse(f.get_as_text())
		f.close()
		var data = json.result
		# Modify
		print(charName, " CHARACTER NAME")
		data["name"] = charName
		# Save
		f = File.new()
		f.open("res://sprites/archer/data/archerData.json", File.WRITE)
		f.store_string(JSON.print(data, "  ", true))
		f.close()
		archer = false 
		caster = true
		charName = ""
	elif caster == true:
		$caster.hide()
		$healer.show()
		
		var f = File.new()
		f.open("res://sprites/caster/data/casterData.json", File.READ)
		var json = JSON.parse(f.get_as_text())
		f.close()
		var data = json.result
		# Modify
		print(charName, " CHARACTER NAME")
		data["name"] = charName
		# Save
		f = File.new()
		f.open("res://sprites/caster/data/casterData.json", File.WRITE)
		f.store_string(JSON.print(data, "  ", true))
		f.close()
		caster = false 
		healer = true 
		charName = ""
		$nextButton.text = "Start"
	elif healer == true: 
		var f = File.new()
		f.open("res://sprites/healer/data/healerData.json", File.READ)
		var json = JSON.parse(f.get_as_text())
		f.close()
		var data = json.result
		# Modify
		print(charName, " CHARACTER NAME")
		data["name"] = charName
		# Save
		f = File.new()
		f.open("res://sprites/healer/data/healerData.json", File.WRITE)
		f.store_string(JSON.print(data, "  ", true))
		f.close()
		
		get_tree().change_scene("res://WorldMap.tscn")
		charName = ""
	charName = ""
	$TextEdit.text = ""
