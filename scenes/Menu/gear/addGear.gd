extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	print("connect dammit")
	connect("mouse_entered",self,"_on_body_enter")
	connect("mouse_exited",self,"_on_body_exit")

func _on_body_enter(): 
	print("Area has been created")