extends Area2D

func _ready():
	connect("body_entered",self,"_on_bossArea_body_enter")

	pass # Replace with function body.

func _on_bossArea_body_enter(body): 
	print(body, "Area has been created")
	
	if body.get_name() == "player":
		get_tree().change_scene("res://battle/BattleTree.tscn")
