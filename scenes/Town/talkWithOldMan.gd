extends Area2D


func _ready():
	connect("body_entered",self,"_on_bossArea_body_enter")
	
	pass # Replace with function body.

func _on_bossArea_body_enter(body): 
	print(body, "Area has been created")
	
	if body.get_name() == "player":
		dialogue()

func dialogue():
	var quest = $quest
	quest.visible = true
	var accept = $quest/acceptQuest
	accept.connect("pressed",self,"acceptQuest")
func acceptQuest():
	var quest = $quest
	quest.visible = false