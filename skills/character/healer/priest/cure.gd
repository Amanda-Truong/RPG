extends Node
var silence
var cd = 0 
var turns = 0
var available = true 
var skillName = "Cure"
var partySkill = true 
var skill = "cure"
var oldPotency 
var oldAtt
var bossDebuff = false
var attack = false
var effectedPlayer 
func _ready():
	pass # Replace with function body.

func skillTrack(player):
	cd = 2
func skillProcess(player):
	effectedPlayer.currentHP = effectedPlayer.currentHP + (100 * player.att * 0.2)

func skillReset(player):
	print("reset")
	effectedPlayer = null 