extends Node

var cd = 0 
var turns = 0
var available = true 
var skillName = "Poison Arrow"
var partySkill = false 
var skill = "poisonArrow"
var oldPotency 
var silence
var bossDebuff = false
var attack = true
func _ready():
	pass # Replace with function body.

func skillTrack(player):
	oldPotency = player.potency
	cd = 8 
	turns = 4

func skillProcess(player):  
	player.potency = 100

func skillReset(player):
	player.potency = oldPotency