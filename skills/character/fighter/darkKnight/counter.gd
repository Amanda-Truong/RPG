extends Node
var silence
var cd = 0
var turns = 0
var available = true 
var skillName = "Counter"
var skill = "counter"
var partySkill = false
var bossDebuff = false
var attack = false
func _ready():
	pass # Replace with function body.


func skillTrack(player):
	cd = 2 
	turns = 1 
func skillProcess(player):  
	player.counter = 1/2

func skillReset(player):
	player.counter = 0