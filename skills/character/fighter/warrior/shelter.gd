extends Node

var cd = 0
var turns = 0
var available = true 
var characterSelected = ""
var skillName = "Shelter" 
var skill = "shelter"
var silence
var bossDebuff = false
var partySkill = true
var attack = false
var effectedPlayer 
func _ready():
	pass # Replace with function body.

func skillTrack(player):
	cd = 4
func skillProcess(player):
	effectedPlayer.shield = player.currentHP * 1/3
	effectedPlayer.maxShield = player.currentHP * 1/3

func skillReset(player):
	print("reset")
	effectedPlayer = []