extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var a = $ScrollContainer/VBoxContainer/dialogue/loadTestSave
	a.connect("pressed",self,"loadSave")
	pass # Replace with function body.

func loadSave():
	get_tree().change_scene("res://scenes/WorldMap.tscn")
	pass 