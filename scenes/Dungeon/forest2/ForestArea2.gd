extends Node2D
var close
var skillTree
var charStats
var inventory
var menu
func _ready():
	close = $back/menu/close.connect("pressed",self,"closeMenu")
	skillTree = $back/menu/skillTree.connect("pressed",self,"skillTree")
	inventory = $back/menu/inventory.connect("pressed",self,"inventory")
	menu = $back
func _input(ev):
	if ev is InputEventKey and ev.scancode == KEY_ESCAPE:   
		
		menu.visible = true

func closeMenu():
	menu.visible = false
func skillTree():
	get_tree().change_scene("res://scenes/Menu/SkillTree.tscn")
func inventory():
	get_tree().change_scene("res://scenes/Menu/Gear.tscn")