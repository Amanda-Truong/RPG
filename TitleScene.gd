extends Node2D

func _ready():
	$background/titlemenu/newButton.connect("pressed",self,"NewGame")
	$background/titlemenu/loadButton.connect("pressed",self,"Load")
	$background/titlemenu/exitButton.connect("pressed",self,"Exit")
	$background/titlemenu/settingsButton.connect("pressed",self,"Settings")
	pass # Replace with function body.

func NewGame(): 
	get_tree().change_scene("res://CharSelect.tscn")
	pass 
func Load():
	get_tree().change_scene("res://LoadGame.tscn")
	pass

func Exit(): 
	get_tree().quit()
	pass 
	
func Settings(): 
	get_tree().change_scene("res://Settings.tscn")
	pass