extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dragMouse = false
# Called when the node enters the scene tree for the first time.
var drag
func _ready():
	print("connect dammit")
	connect("mouse_entered",self,"_on_body_enter")
	connect("mouse_exited",self,"_on_body_exit")

func _on_body_enter(): 
	print("Area has been created")
	drag = true

func _on_body_exit():
	print("EXIT!")
	drag = false

func _process(delta):
	if(dragMouse == true && drag == true):
		print("Drag mouse")
		var c = get_viewport().get_mouse_position()
		print(c)
		c.x = c.x + 200 
		c.y = c.y - 150
		set_position(c)
	pass
func _input(ev):
	if ev is InputEventKey and ev.scancode == KEY_J:   
		dragMouse = true
	if ev is InputEventKey and ev.scancode == KEY_K: 
		dragMouse = false
