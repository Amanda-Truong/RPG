extends Node

var cd = 0
var turns = 0 
var available = true
var skillName = "Taunt"
var skill = "taunt"
var partySkill = false
var silence
var bossDebuff = false
var attack = false
func _ready():
	pass # Replace with function body.

func skillTrack(player):
	cd = 5 
	turns = 3 

func skillProcess(player): 
	player.chanceHit = 90

func skillReset(player): 
	if player.type == "fighter": 
		player.chanceHit = 29 
	if player.type == "caster": 
		player.chanceHit = 23 
	if player.type == "archer":
		player.chanceHit = 25
	if player.type == "healer":
		player.chanceHit = 23