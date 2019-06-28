extends Button

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("ready",self,"skillClick")
	pass # Replace with function body.

func skillClick(): 
	var skillBranch = $actionPanel
	print(skillBranch)
