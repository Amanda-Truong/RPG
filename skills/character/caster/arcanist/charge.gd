extends Node
var silence
var cd = 0 
var turns = 0
var available = true 
var skillName = "Charge"
var partySkill = true 
var skill = "charge"
var oldPotency 
var oldAtt
var attack = false
var effectedPlayer 
var bossDebuff = false
func _ready():
	pass # Replace with function body.

func skillTrack(player):
	print(player)
	
	cd = 4
	turns = 1
	oldAtt = player.att
func skillProcess(player):
	player.att = player.att * 1.2

func skillReset(player):
	print("reset")
	player = oldAtt