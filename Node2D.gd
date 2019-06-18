extends Node2D
var charName = ""
func _ready():
	$nextButton.connect("pressed",self,"Next")
	
	pass 

func _on_nextButton_pressed():
	print("WHY")
	
func _on_TextEdit_text_changed(new_text):
	 print("Text changed!")
	 print($TextEdit.text)
	 charName = $TextEdit.text
	 print(charName)
	 

func Next(): 
 
	get_tree().change_scene("res://WorldMap.tscn")
	
	pass 