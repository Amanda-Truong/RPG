extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var screen_size
# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	screen_size = self.get_viewport_rect().size
	pass # Replace with function body.

func update_viewport():

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
