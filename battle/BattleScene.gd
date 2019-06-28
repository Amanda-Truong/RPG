extends Node2D

var branchOne 
var branchTwo
var branchThree 

var choiceOne
var choiceTwo 
var choiceThree 

var fighter
var caster 
var healer 
var archer 

var battleEnd = false 
var party = ["healer","caster","archer","fighter"] 
var boss 
var win
var fail 

var charSelect

var panel1
var panel2
var panel3

var battlerHP
var battlerName
var string = ""
var whoseTurn = "fighter"

var justHit 
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("ready",self,"battle_start")
	randomize()
	
	
	pass # Replace with function body.

func battle_start():
	print("LETS GET READY TO RUMBLE!")
	
	fighter = $fighter
	caster = $caster 
	healer = $healer 
	archer = $archer
	boss = $treeguard
	boss.shield = 1000
	boss.harden()
	$actionPanel/actionChoice/skill.connect("pressed",self,"skillClick")
	$actionPanel/actionChoice/attack.connect("pressed",self,"attackClick")
	
	$actionPanel/skillChoice/choiceOne.connect("pressed",self,"skillChoiceOne")
	$actionPanel/charSelect/casterSelect.connect("pressed",self,"casterSelect") 
	$actionPanel/charSelect/archerSelect.connect("pressed",self,"archerSelect")
	$actionPanel/charSelect/fighterSelect.connect("pressed",self,"fighterSelect")
	$actionPanel/charSelect/healerSelect.connect("pressed",self,"healerSelect")
	
	charSelect = $actionPanel/charSelect
	
	$actionPanel/skillBranch/branchOne.connect("pressed",self,"branchOne")
	$actionPanel/skillBranch/branchTwo.connect("pressed",self,"branchTwo")
	$actionPanel/skillBranch/branchThree.connect("pressed",self,"branchThree")
	

	player_turn()

func boss_turn():
	var sprite = $healerAtt
	sprite.hide()
	healer.show()
	if boss.currentHP < 1000 && boss.harden == 1:
		boss.harden()
		boss.harden = boss.harden - 1
	
	panel1 = $actionPanel/actionChoice 
	panel1.hide()
	panel2 = $actionPanel/skillBranch
	panel2.hide()
	panel3 = $actionPanel/skillChoice
	panel3.hide() 
	$actionPanel/portrait/battlerName.text = "Treeguard"
	print("BOSS TURN!")
	
	var head = $actionPanel/portrait/healerHead
	head.hide()
	var head1 = $actionPanel/portrait/bossHead 
	head1.show()
	
	battlerHP.text = "HP " + str(boss.currentHP) + " / " + str(boss.maximumHP)
	
	var bossAttack = $actionPanel/bossAttack
	bossAttack.text = ""
	var rand = randi()%101+1
	var toHit = 0
	print(rand, " RANDOM NUMBER TO HIT A PLAYER!!!!")
	string = ""
	
	if(boss.silence != true):
		if(rand <= fighter.chanceHit):
			hitPlayer(boss.attack(), fighter)
		if(rand > fighter.chanceHit && rand <= archer.chanceHit + fighter.chanceHit):
			
			hitPlayer(boss.attack(), archer)
		if(rand > archer.chanceHit + fighter.chanceHit && rand <= archer.chanceHit + fighter.chanceHit + caster.chanceHit):
			
			hitPlayer(boss.attack(), caster)
		if( rand > archer.chanceHit + fighter.chanceHit + caster.chanceHit && rand <= 100): 
			hitPlayer(boss.attack(), healer)
	if boss.silence == true: 
		string = "Treeguard is silenced!" 
	bossAttack.show()
	
	var temp = ""
	
	# The old way:
			# Code before the yield
	# Setting up the yield:
	var t = Timer.new() 		# Create a new Timer node
	
	add_child(t)			# Add it to the node tree as the direct child
	t.start()			# Start it
	yield(t, "timeout")		# Finally, make the script stop with the yield

	
	
	
	for letter in string: 
		temp = temp + letter
		bossAttack.text = temp
		yield(get_tree().create_timer(.1),"timeout")
	yield(get_tree().create_timer(2),"timeout")
	whoseTurn = "fighter"
	fighter.turn = 1
	
	
	if(healer.regenWho == true && healer.regenChar != null):
		var a = healer.regenChar 
		if a == "fighter":
			fighter.currentHP = fighter.currentHP + healer.regen()
		if a == "archer": 
			archer.currentHP = archer.currentHP + healer.regen()
		if a == "healer": 
			healer.currentHP = healer.currentHP + healer.regen()
		if a == "caster": 
			caster.currentHP = caster.currentHP + healer.regen()

	player_turn()
	checkTurns()
	checkCD()

func hitPlayer(hit,player):
	print("Treeguard hit for " + str(hit))
	justHit = str(player.get_name())
	if(justHit == "fighter" && fighter.counter != 0):
		hitBoss(fighter.attack()/2)
	player.currentHP = player.currentHP - hit
	string = "Treeguard used 'Attack' on " + str(player.get_name()) + "!!!"


func player_turn(): 

	var bossHead = $actionPanel/portrait/bossHead 
	bossHead.hide()
	var bossAttack = $actionPanel/bossAttack
	bossAttack.hide()
	
	panel1 = $actionPanel/actionChoice 
	panel1.show()
	panel2 = $actionPanel/skillBranch
	panel2.show()
	panel3 = $actionPanel/skillChoice
	panel3.show() 
	

	
	branchOne = $actionPanel/skillBranch/branchOne
	branchTwo = $actionPanel/skillBranch/branchTwo
	branchThree = $actionPanel/skillBranch/branchThree
	
	choiceOne = $actionPanel/skillChoice/choiceOne 
	
	battlerName = $actionPanel/portrait/battlerName
	battlerHP = $actionPanel/portrait/battlerHP
	

	choiceOne.disabled = false
	
	if fighter.currentHP <= 0:
		fighter.dead = true
	if archer.currentHP <= 0:
		fighter.dead = true 
	if healer.currentHP <= 0: 
		healer.dead = true 
	if caster.currentHP <= 0: 
		caster.dead = true 
	
	var turns = 0
	if fighter.turn == 1 && fighter.dead != true: 
			whoseTurn = "fighter"
			var head = $actionPanel/portrait/fighterHead
			var sprite = $fighterAtt 
			$actionPanel/portrait/battlerName.text = fighter.fighterName
			fighter.hide() 
			sprite.show()
			battlerHP.text = "HP " + str(fighter.currentHP) + " / " + str(fighter.maximumHP)
			head.show()
	if caster.turn == 1 && caster.dead != true: 
			whoseTurn = "caster"
			var head1 = $actionPanel/portrait/archerHead
			head1.hide()
			var head = $actionPanel/portrait/casterHead
			var sprite = $casterAtt
			var sprite2 = $archerAtt
			$actionPanel/portrait/battlerName.text = caster.casterName
			archer.show()
			sprite2.hide()
			caster.hide()
			sprite.show()
			battlerHP.text = "HP " + str(caster.currentHP) + " / " + str(caster.maximumHP)
			head.show()
	if healer.turn == 1 && healer.dead != true: 
			whoseTurn = "healer"
			var head1 = $actionPanel/portrait/casterHead
			head1.hide()
			$actionPanel/portrait/battlerName.text = healer.healerName
			var head = $actionPanel/portrait/healerHead
			var sprite = $healerAtt
			var sprite2 = $casterAtt
			caster.show()
			healer.hide()
			sprite.show()
			sprite2.hide()
			battlerHP.text = "HP " + str(healer.currentHP) + " / " + str(healer.maximumHP)
			head.show()
	if archer.turn == 1 && archer.dead != true: 
			whoseTurn = "archer"
			var head1 = $actionPanel/portrait/fighterHead
			head1.hide()
			$actionPanel/portrait/battlerName.text = archer.archerName
			var head = $actionPanel/portrait/archerHead
			var sprite = $fighterAtt
			var sprite2 = $archerAtt
			sprite.hide()
			fighter.show()
			archer.hide()
			sprite2.show()
			battlerHP.text = "HP " + str(archer.currentHP) + " / " + str(archer.maximumHP)
			head.show()

func checkTurns():
	if fighter.taunt != 0:
		fighter.taunt = fighter.taunt - 1
	else:
		fighter.chanceHit = 29 
		archer.chanceHit = 25
		healer.chanceHit = 23 
		caster.chanceHit = 23
	
	if fighter.counter != 0:
		fighter.counter = fighter.counter - 1 
	if archer.poisonArrow != 0: 
		archer.poisonArrow = archer.poisonArrow - 1
		hitBoss(archer.poisonArrow)
	if healer.regen != 0:
		healer.regen = healer.regen - 1
	else: 
		healer.regenWho = false
	if caster.silence != 0: 
		caster.silence = caster.silence - 1 
	else: 
		boss.silence = false
	if caster.charge != 0:
		caster.charge = caster.charge - 1
	else:
		fighter.att = 10 
		archer.att = 10 
		caster.att = 7 
		healer.att = 7


func checkCD(): 

	if fighter.tauntCD != 0:
		fighter.tauntCD = fighter.tauntCD - 1
	if fighter.counterCD != 0:
		fighter.counterCD = fighter.counterCD - 1 
	if fighter.shelterCD != 0:
		fighter.shelterCD = fighter.shelterCD - 1
	if archer.powerShotICD != 0:
		archer.powerShotICD = archer.powerShotICD - 1
	if archer.poisonArrowCD != 0:
		archer.poisonArrowCD = archer.poisonArrowCD - 1
	if archer.barrageICD != 0:
		archer.barrageICD = archer.barrageICD - 1
	if healer.cureCD != 0: 
		healer.cureCD = healer.cureCD - 1 
	if healer.galvanizeCD != 0: 
		healer.galvanizeCD = healer.galvanizeCD - 1 
	if healer.regenCD != 0: 
		healer.regenCD = healer.regenCD - 1 
	if caster.fireCD != 0: 
		caster.fireCD = caster.fireCD - 1 
	if caster.silenceCD != 0: 
		caster.silenceCD = caster.silenceCD - 1 
	if caster.chargeCD != 0:
		caster.chargeCD = caster.chargeCD - 1 


func skillClick():
	if whoseTurn == "fighter":
		branchOne.text = "Paladin" 
		branchOne.show()
		branchTwo.text = "Dark Knight" 
		branchTwo.show()
		branchThree.text = "Warrior" 
		branchThree.show()
	if whoseTurn == "archer":
		branchOne.text = "Sniper" 
		branchOne.show()
		branchTwo.text = "Ranger" 
		branchTwo.show()
		branchThree.text = "Trapper" 
		branchThree.show()
	if whoseTurn == "healer":
		branchOne.text = "Priest" 
		branchOne.show()
		branchTwo.text = "Scholar" 
		branchTwo.show()
		branchThree.text = "Cleric" 
		branchThree.show()
	if whoseTurn == "caster":
		branchOne.text = "Sorcerer" 
		branchOne.show()
		branchTwo.text = "Warlock" 
		branchTwo.show()
		branchThree.text = "Arcanist" 
		branchThree.show()

func branchOne():

	if whoseTurn == "fighter":
		choiceOne.text = "Taunt" 
		choiceOne.show()
		if fighter.tauntCD != 0 && choiceOne.text == "Taunt":
				choiceOne.disabled = true
		else: 
				choiceOne.disabled = false
	if whoseTurn == "archer":
		choiceOne.text = "Power Shot I"
		choiceOne.show()
		if archer.powerShotICD != 0 && choiceOne.text == "Power Shot I":
				choiceOne.disabled = true
		else: 
				choiceOne.disabled = false
	
	if whoseTurn == "healer":
		choiceOne.text = "Cure"
		choiceOne.show()
		if healer.cureCD != 0 && choiceOne.text == "Cure":
				choiceOne.disabled = true
		else: 
				choiceOne.disabled = false
	if whoseTurn == "caster":
		choiceOne.text = "Fire"
		if caster.fireCD != 0 && choiceOne.text == "Fire":
			choiceOne.disabled = true 
		else: 
			choiceOne.disabled = false
		choiceOne.show()

func branchTwo():
	if whoseTurn == "fighter":
		choiceOne.text = "Counter" 
		choiceOne.show()
		if fighter.counterCD != 0 && choiceOne.text == "Counter":
				choiceOne.disabled = true
		else: 
				choiceOne.disabled = false
	if whoseTurn == "archer":
		choiceOne.text = "Barrage I"
		choiceOne.show()
		if archer.barrageICD != 0 && choiceOne.text == "Barrage I":
				choiceOne.disabled = true
		else: 
				choiceOne.disabled = false
	if whoseTurn == "healer":
		choiceOne.text = "Galvanize"
		choiceOne.show()
		if healer.galvanizeCD != 0 && choiceOne.text == "Galvanize":
				choiceOne.disabled = true
		else: 
				choiceOne.disabled = false
	if whoseTurn == "caster":
		choiceOne.text = "Silence"
		if caster.silenceCD != 0 && choiceOne.text == "Silence":
			choiceOne.disabled = true 
		else: 
			choiceOne.disabled = false 
		choiceOne.show()

func branchThree():
	if whoseTurn == "fighter":
		choiceOne.text = "Shelter" 
		choiceOne.show()
		if fighter.shelterCD != 0 && choiceOne.text == "Shelter":
				choiceOne.disabled = true
		else: 
				choiceOne.disabled = false
	if whoseTurn == "archer":
		choiceOne.text = "Poison Arrow"
		choiceOne.show()
		if archer.poisonArrowCD != 0 && choiceOne.text == "Poison Arrow":
				choiceOne.disabled = true
		else: 
				choiceOne.disabled = false
	if whoseTurn == "healer":
		choiceOne.text = "Regen"
		choiceOne.show()
		if healer.regenCD != 0 && choiceOne.text == "Regen":
				choiceOne.disabled = true
		else: 
				choiceOne.disabled = false
	if whoseTurn == "caster":
		choiceOne.text = "Charge"
		if caster.chargeCD != 0 && choiceOne.text == "Charge":
				choiceOne.disabled = true 
		else: 
				choiceOne.disabled = false 
		choiceOne.show()


func skillChoiceOne(): 
	
	if whoseTurn == "fighter":
		
		fighter.turn = 0
		var click = $actionPanel/skillChoice/choiceOne

		if click.text.to_lower() == "taunt":
			print("Fighter is taunting!")
			fighter.taunt()
			archer.turn = 1
			whoseTurn = ""
			
		if click.text.to_lower() == "counter":
			print("Fighter is countering!")
			fighter.counter()
			archer.turn = 1
			whoseTurn = ""

		if click.text.to_lower() == "shelter":
			fighter.shelterWho = true
			fighter.shelterCD = 4
			charSelect.show()
		
	
	if whoseTurn == "archer":
		archer.turn = 0
		
		var click = $actionPanel/skillChoice/choiceOne
		
		if click.text == "Power Shot I":
			print("Archer is power shot I!")
			hitBoss(archer.powerShotI())
		if click.text == "Barrage I":
			print("Archer is using barrage I!")
			hitBoss(archer.barrageI())
		if click.text == "Poison Arrow":
			print("Archer is using poison arrow!")
			archer.poisonArrow = 4
			archer.poisonArrowCD = 9
			hitBoss(archer.poisonArrow())
	
		caster.turn = 1 
		whoseTurn = ""
	
	if whoseTurn == "caster":
		caster.turn = 0
		var click = $actionPanel/skillChoice/choiceOne
		
		if click.text == "Fire":
			print("Caster is using FIRE!") 
			hitBoss(caster.fire())
			healer.turn = 1
			whoseTurn = ""
		if click.text == "Silence":
			print("Caster is using SILENCE!") 
			caster.silenceCD = 6
			boss.silence = true
			healer.turn = 1
			whoseTurn = ""
		if click.text == "Charge":
			print("Caster is using CHARGE!")
			caster.chargeWho = true
			caster.chargeCD = 4 
			caster.charge = 1
			charSelect.show()

	
	if whoseTurn == "healer":
		healer.turn = 0
		var click = $actionPanel/skillChoice/choiceOne
		
		if click.text == "Cure":
			print("Healer is using cure!") 
			charSelect.show()
			healer.cureWho = true 
		if click.text == "Galvanize":
			print("Healer is using galvanize!") 
			charSelect.show()
			healer.galvanizeWho = true 
		if click.text == "Regen": 
			print("Healer is using regen!") 
			charSelect.show()
			healer.regenCD = 5 
			healer.regen = 4
			healer.regenWho = true
		
	branchOne.hide()
	branchTwo.hide()
	branchThree.hide()
	choiceOne.hide()
	if whoseTurn != "boss":
		player_turn()

func attackClick(): 
	if whoseTurn == "fighter":
		
		fighter.turn = 0
		hitBoss(fighter.attack())
		archer.turn = 1
		whoseTurn = ""
		
	if whoseTurn == "archer":
		archer.turn = 0
		hitBoss(archer.attack())
		caster.turn = 1 
		whoseTurn = ""
	
	if whoseTurn == "caster":
		caster.turn = 0
		hitBoss(caster.attack())
		healer.turn = 1
		whoseTurn = ""
	
	if whoseTurn == "healer":
		healer.turn = 0
		hitBoss(healer.attack())
		whoseTurn = "boss"
		boss_turn()
	branchOne.hide()
	branchTwo.hide()
	branchThree.hide()
	choiceOne.hide()
	if whoseTurn != "boss":
		player_turn()

func healerSelect():
	print("********************************")
	print(healer.cureWho) 
	print(healer.regenWho) 
	print(healer.galvanizeWho) 
	print(fighter.shelterWho) 
	print(caster.chargeWho)
	print("********************************")
	if(healer.cureWho == true):
		healer.currentHP = healer.currentHP + healer.cure() 
		healer.cureWho = false
		charSelect.hide()
		whoseTurn = "boss"
		boss_turn()
	if(healer.regenWho == true):
		healer.regenChar = "healer"
		healer.regenWho = false 
		charSelect.hide() 
		whoseTurn = "boss" 
		boss_turn()
	if(healer.galvanizeWho == true):
		healer.currentHP = healer.currentHP + healer.galvanize()
		charSelect.hide()
		healer.galvanizeWho = false
		whoseTurn = "boss" 
		boss_turn()
	if(fighter.shelterWho == true):
		healer.currentHP = healer.currentHP + fighter.shelter()
		fighter.shelterWho = false
		archer.turn = 1
		whoseTurn = ""
		charSelect.hide() 
		player_turn()
	if(caster.chargeWho == true):
		healer.att = healer.att * caster.charge() 
		print(caster.chargeWho, " BEFORE !") 
	
		caster.chargeWho = false 
		
		print(caster.chargeWho, " AFTER!!!")
		healer.turn = 1
		whoseTurn = "" 
		charSelect.hide()
		player_turn()

func archerSelect():
	if(healer.cureWho == true):
		archer.currentHP = archer.currentHP + healer.cure()
		healer.cureWho = false
		charSelect.hide()
		whoseTurn = "boss"
		boss_turn()
	if(healer.regenWho == true):
		charSelect.hide()
		healer.regenWho = false
		healer.regenChar = "archer"
		whoseTurn = "boss"
		boss_turn()
	if(healer.galvanizeWho == true):
		archer.currentHP = archer.currentHP + healer.galvanize()
		charSelect.hide()
		healer.galvaizeWho = false 
		whoseTurn = "boss" 
		boss_turn()
	if(fighter.shelterWho == true):
		archer.currentHP = archer.currentHP + fighter.shelter()
		archer.turn = 1
		whoseTurn = ""
		fighter.shelterWho = false 
		charSelect.hide() 
		player_turn()
	if(caster.chargeWho == true):
		archer.att = archer.att * caster.charge() 
		caster.chargeWho = false 
		whoseTurn = "" 
		charSelect.hide()
		healer.turn = 1
		player_turn()

func fighterSelect():
	if(healer.cureWho == true):
		fighter.currentHP = fighter.currentHP + healer.cure()
		healer.regenChar = false
		charSelect.hide()
		whoseTurn = "boss"
		boss_turn()
	if(healer.regenWho == true): 
		charSelect.hide()
		healer.regenWho = false
		healer.regenChar = "fighter"
		whoseTurn = "boss" 
		boss_turn()
	if(fighter.shelterWho == true):
		fighter.currentHP = fighter.currentHP + fighter.shelter()
		archer.turn = 1
		whoseTurn = ""
		charSelect.hide() 
		fighter.shelterWho = false
		player_turn()
	if(healer.galvanizeWho == true):
		fighter.currentHP = fighter.currentHP + healer.galvanize()
		charSelect.hide()
		whoseTurn = "boss" 
		healer.galvanizeWho = false
		boss_turn()
	if(caster.chargeWho == true):
		fighter.att = fighter.att * caster.charge() 
		caster.chargeWho = false 
		whoseTurn = "" 
		charSelect.hide()
		caster.chargeWho = false
		healer.turn = 1
		player_turn()

func casterSelect(): 
	if(healer.cureWho == true):
		caster.currentHP = caster.currentHP + healer.cure()
		healer.cureWho = false
		charSelect.hide()
		whoseTurn = "boss"
		boss_turn()
	if(healer.regenWho == true):
		charSelect.hide()
		healer.regenWho = false
		healer.regenChar = "caster" 
		whoseTurn = "boss" 
		boss_turn()
	if(fighter.shelterWho == true):
		caster.currentHP = caster.currentHP + fighter.shelter()
		archer.turn = 1
		whoseTurn = ""
		charSelect.hide() 
		fighter.shelterWho = false
		player_turn()
	if(healer.galvanizeWho == true):
		caster.currentHP = caster.currentHP + healer.galvanize()
		charSelect.hide()
		healer.galvanizeWho = false
		whoseTurn = "boss" 
		boss_turn()
	if(caster.chargeWho == true):
		caster.att = caster.att * caster.charge() 
		caster.chargeWho = false 
		whoseTurn = "" 
		charSelect.hide()
		healer.turn = 1
		player_turn()


func hitBoss(hit):
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!") 
	print(hit, "   HIT!") 
	print(boss.currentHP, " CURRET HP!") 
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	boss.set_process(true)
	var t = Timer.new() 		# Create a new Timer node
	var treeHit = $treeHit
	treeHit.text = "-" + str(hit)
	treeHit.show()
	add_child(t)			# Add it to the node tree as the direct child
	t.start()			# Start it
	yield(get_tree().create_timer(0.4),"timeout")	# Finally, make the script stop with the yield
	boss.set_process(false)
	yield(get_tree().create_timer(0.4),"timeout")
	treeHit.hide()
	boss.currentHP = boss.currentHP - hit
