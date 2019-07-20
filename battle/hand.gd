extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
var speed = 400
var pos_inicial
var pos_final 

func _ready():
    set_process(false)
    pos_inicial = true
    pos_final = false

func _process(delta):
    var move = Vector2()
    if pos_inicial:
        move.x = speed
        if position.x >= 400:
            pos_inicial = false
            pos_final = true

    if pos_final:
        move.x = -speed
        if position.x <= 390:
            pos_inicial = true
            pos_final = false
    position += move * 0.0166