extends Node
var turnCount = 0
var currentHP 
var att 
var shield = 0
var bossName = "TreeGuard"
var maxHP
var potency 
var maxShield 
var silence = false
var skillsApplied = [] 
var skillsAvailable = [] 
var alive = true
func _ready():
	setGear()
	pass # Replace with function body.

func setGear(): 
	maxHP = 3500 
	currentHP = 3500
	att = 10 
	
func harden():
	currentHP = currentHP + 1000

func attack():
	potency = 100
func hit(turnQue):
	var totalHitPer = 0
	var bracket = []
	var hitWho 
	for player in turnQue:
		player.order = 0 
		bracket.append(totalHitPer)
		totalHitPer = totalHitPer + player.chanceHit
		
		player.order = player.order + totalHitPer 
		print("\\\\\\\\\///////\\\\\\/////")
		print(player.order)
		print("\\\\\\\\\///////\\\\\\/////")
	var rando = rand_range(1,totalHitPer)
	print("WE ARE HITTING THIS RANGE")
	print(rando)
	for player in turnQue:
		var i = 0
		for b in bracket:
			print("We are in these brackets!") 
			print(bracket[i])
			if i != bracket.size()-1 :
				print(bracket[i+1])
			if((rando > bracket[i] && rando <= bracket[i+1]) && (player.order > bracket[i] && player.order <= bracket[i+1])):
				hitWho = player.type
				if(player.shield <= 0):
					player.currentHP = player.currentHP - (potency * att * 0.1)
				else: 
					player.shield = player.shield - (potency * att * 0.1) 
					if(player.shield < 0):
						var temp = abs(player.shield)
						player.currentHP = player.currentHP - temp
				print("BOSS HITS!") 
				print("FOLLOWING PLAYER:")
				print(player.type)
			i = i + 1 
	print("@@@@@@@@@@@END OF HIT@@@@@@@@@@@")
	bracket.clear()
	totalHitPer = 0
	return hitWho
func smash(): 
	potency = 200
func turn(): 
	if currentHP == 3500:
		shield = 1000
		maxShield = 1000
	if currentHP < 1000:
		shield = 1000
		maxShield = 1000

	turnCount = turnCount + 1 
	if (turnCount % 4 == 0) && (silence == false):
		smash()
	else: 
		attack()
	print("Tree's turns!") 