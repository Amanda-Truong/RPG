extends Node
var silence
var cd = 0 
var turns = 0
var available = true 
var skillName = "Fire"
var partySkill = false 
var skill = "fire"
var oldPotency 
var attack = true
var bossDebuff = false
func _ready():
	pass # Replace with function body.

func skillTrack(player):
	oldPotency = player.potency
	cd = 2


func skillProcess(player):  
	player.potency = 400

func skillReset(player):
	player.potency = oldPotency