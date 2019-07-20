extends Area2D

# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"_on_bossArea_body_enter")
	$dialogue/dungeonYes.connect("pressed",self,"bossYes")
	$dialogue/dungeonNo.connect("pressed",self,"bossNo")
	
	pass # Replace with function body.

func _on_bossArea_body_enter(body): 
	print(body, "Area has been created")
	
	if body.get_name() == "player":
		var enterBoss = $dialogue
		print("player entered area")
		print(enterBoss, "Boss boss")
		var setX = body.position.x
		var setY = body.position.y
		$dialogue.show()
		print(body.position.x, "position x") 
		print(body.position.y, "position y")
		print(enterBoss.position.x, "position x of boss") 
		print(enterBoss.position.y, "position y of boss ")
		#enterBoss.set_position(Vector2(enterBoss.position.x + setX, enterBoss.position.y + setY + 10))
		
		
		#get_tree().change_scene("res://battle/BattleScene.tscn")
	
	

func bossYes(): 
	print("OK LETS BATTLE!")
	get_tree().change_scene("res://ForestArea2.tscn")
	
func bossNo(): 
	print("WHAT? fine fine")