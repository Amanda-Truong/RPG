extends Node

var cd = 0 
var turns = 0
var available = true 
var skillName = "Barrage I"
var partySkill = false 
var skill = "barrageI"
var oldPotency 
var bossDebuff = false
var silence
var attack = true
func _ready():
	pass # Replace with function body.

func skillTrack(player):
	oldPotency = player.potency
	cd = 3 

func skillProcess(player):  
	player.potency = 200

func skillReset(player):
	player.potency = oldPotency