extends Node

var cd = 0 
var turns = 0
var available = true 
var skillName = "Silence"
var partySkill = false 
var skill = "silence"
var oldPotency 
var attack = false
var silence 
var bossDebuff = true
func _ready():
	pass # Replace with function body.

func skillTrack(player):
	cd = 6
	turns = 1

func skillProcess(player):  
	silence = true

func skillReset(player):
	silence = false