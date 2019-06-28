extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$dungeonYes.connect("pressed",self,"bossYes")
	$dungeonNo.connect("pressed",self,"bossNo")
	pass # Replace with function body.

func bossYes():
	print("ok..lets go!") 

func bossNo():
	print("fine stay...")
