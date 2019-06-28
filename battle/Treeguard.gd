extends Sprite

var maximumHP = 3500 
var currentHP = 3500 
var att = 10 
var dead
var turnsTaken = 0
var turn = 0 
var silence
var shield = 0
var smashCD = 0
var harden = 1
var smashPotency = 200
var attPotency = 100


func harden(): 
	currentHP = currentHP + 1000

func attack():
	return attPotency * (att * 0.1)
	
func smash(): 
	return smashPotency * (att * 0.1)


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