extends Node2D

var charInfo 

func _ready():
	print("Play this scene")
	var scene = preload("res://battle/BattleInstance.gd").new()
	print("uhhhhh")
	scene._ready()
	#scene.battle_start()
	scene.battle_start2()
	scene.connect("whoseTurn", self, "signal_handler")
	pass 
	
func signal_handler():
	print("ANAL")