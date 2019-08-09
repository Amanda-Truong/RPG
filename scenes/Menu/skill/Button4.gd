extends Button
var press
var a 
# Called when the node enters the scene tree for the first time.
func _ready():
	print("connect dammit")
	a = $"."
	connect("mouse_entered",self,"_on_body_enter")
	connect("mouse_exited",self,"_on_body_exit")

func _on_body_enter(): 
	print("Area has been created")
	if(press == true):
		a.disabled = false
		a.connect("pressed",self,"buy")
func _input(ev):
	if ev is InputEventKey and ev.scancode == KEY_J:   
		press = true
	if ev is InputEventKey and ev.scancode == KEY_K: 
		press = false
func buy():
	 a.hint_tooltip = ""
	 var c = $Label
	 c.text  = "Current Skill Points: 0"