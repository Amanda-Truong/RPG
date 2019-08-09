extends Node

var cd = 0
var turns = 0
var available = true 
var characterSelected = ""
var skillName = "Power Shot I" 
var skill = "powerShotI"
var partySkill = false
var attack = true
var silence
var bossDebuff = false
var effectedPlayer = []
var oldPotency 
func _ready():
	pass # Replace with function body.

func skillTrack(player):
	cd = 3
	oldPotency = player.potency 
func skillProcess(player):
	player.potency = 300

func skillReset(player):
	player.potency = oldPotency