extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _input(ev):
    if ev is InputEventKey and ev.scancode == KEY_ESCAPE:
     	print("aa")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
