extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var menu
# Called when the node enters the scene tree for the first time.
func _ready():
	var pp = $menu
	pp.hide()

	pass # Replace with function body.
func _input(ev):
	if ev is InputEventKey and ev.scancode == KEY_ESCAPE:
		print("aa")
		var pp = $menu
		var character = $TileMap/KinematicBody2D/AnimatedSprite
		position = character.get_position()
		print(position)
		pp.position.x = position.x 
		pp.position.y = position.y
		pp.show()
	if ev is InputEventKey and ev.scancode == KEY_1:
		var pp = $menu
		pp.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
