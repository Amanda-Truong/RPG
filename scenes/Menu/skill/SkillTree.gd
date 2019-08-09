extends Node2D

var save 
var back 
var menu
# Called when the node enters the scene tree for the first time.
func _ready():
	save = $menu/save.connect("pressed",self,"save")
	back = $menu/back.connect("pressed",self,"back")
	menu = $menu
func _input(ev):
	if ev is InputEventKey and ev.scancode == KEY_ESCAPE :   
		menu.visible = true
	if ev is InputEventKey and ev.scancode == KEY_1:
		menu.visible = false


func save():
	get_tree().change_scene("res://scenes/Dungeon/forest2/ForestArea2.tscn")
func back():
	get_tree().change_scene("res://scenes/Dungeon/forest2/ForestArea2.tscn")