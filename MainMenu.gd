extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$newButton.connect("pressed",self,"NewGame")
	$loadButton.connect("pressed",self,"Load")
	$exitButton.connect("pressed",self,"Exit")
	$settingsButton.connect("pressed",self,"Settings")
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