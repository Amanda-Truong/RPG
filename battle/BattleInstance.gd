extends Node


var battleEnd = false 

var party = []
 
var win
var fail

var turnQue = []
var partyAlive = []
var turnText
var fighter 
var archer 
var healer 
var caster 
var panel
var boss 


signal whoseTurn


func _ready():
	print("Start Battle Instance")
	turnText = $turnText
	panel = $selectCharacter
	#TEST JUNK 
	#TEST JUNK END 
	fighter = preload("res://skills/character/fighter/fighter.gd").new()
	fighter._ready()
	fighter.player = fighter
	fighter.setGear()
	archer =  preload("res://skills/character/archer/archer.gd").new()
	archer._ready()
	archer.player = archer
	archer.setGear()
	healer = preload("res://skills/character/healer/healer.gd").new()
	healer._ready()
	healer.player = healer
	healer.setGear()
	caster = preload("res://skills/character/caster/caster.gd").new()
	caster._ready()
	caster.setGear()
	caster.player = caster
	party = [fighter, archer, caster, healer]  
	boss = preload("res://skills/boss/tree.gd").new()  
	boss._ready()
	boss.turn()
	boss.setGear()
	statUpdate()
	setCharacterNames()
	roundStart()


func setCharacterNames():
	var charInfo = load("res://data/character/CharacterInfo.gd")
	charInfo = charInfo.new() 
	charInfo.characterNames()
	fighter.fighterName = charInfo.fighterName 
	$menu/playerHP/fighter/fighterName.text = fighter.fighterName
	archer.archerName = charInfo.archerName 
	$menu/playerHP/archer/archerName.text = archer.archerName
	healer.healerName = charInfo.healerName 
	$menu/playerHP/healer/healerName.text = healer.healerName
	caster.casterName = charInfo.casterName 
	$menu/playerHP/caster/casterName.text = caster.casterName
	statUpdate()


func subClassSelected(button, player):
	var subClass = button.text
	subClass = subClass.to_lower()
	var skills = $menu/skillSelect/scrollContainer/skillList
	var clearSkills = skills.get_children()
	for clear in clearSkills:
		if clear.get_name() != "hand3":
			clear.free()
	addSkills(player, player.getSkill(subClass))

func currentlyAlive():
	partyAlive.clear()
	for p in party:
		if p.alive == true: 
			partyAlive.append(p)

func roundStart():
	if battleEnd == false:
		var rounds = 0 
		print("Top of the Round")
		for p in party:
			if p.alive == true: 
				currentlyAlive()
				turnQue.append(p)
		playerTurn(turnQue)


func skillButtonReady(button):
	button.set_size(Vector2 (200, 100))
	
func skillBack():
	var container = $menu/skillSelect
	container.visible = false 

func addSkills(player, skills): 
	var skillMenu = $menu/skillSelect
	skillMenu.visible = true
	var container = $menu/skillSelect/scrollContainer/skillList
	var back = $menu/skillSelect/skillBack
	back.connect("pressed",self,"skillBack")
	var hand = $menu/skillSelect/scrollContainer/skillList/hand3
	hand.flip_h = true
	for skill in skills: 
		var button = Button.new()
		print("SKILL")
		print(skill.skill)
		button.text = skill.skillName
		button.flat = true
		button.name = skill.skill 
		button.focus_mode = Control.FOCUS_NONE
		if(skill.partySkill == false):
			button.connect("pressed",self,"skillSelected", [player,button,skill])
		if(skill.partySkill == true):
			button.connect("pressed",self,"selectCharacter", [player,button,skill])
		button.connect("mouse_entered",self,"handHover2",[button,hand])
		button.connect("mouse_exited",self,"handHoverEnd2",[button,hand])
		container.add_child(button)

func playerActivity(player):
	var container = $menu/actionSelect/actionSelectContainer
	var hand = $menu/actionSelect/actionSelectContainer/hand
	var action = $menu/actionSelect 
	
	action.visible = true
	var subClass = $menu/subClass
	subClass.visible = false
	var skills = $menu/skillSelect
	skills.visible = false
	var skillButton = Button.new()
	skillButton.flat = true
	skillButton.focus_mode = Control.FOCUS_NONE
	var attackButton = Button.new() 
	attackButton.flat = true
	attackButton.focus_mode = Control.FOCUS_NONE
	
	skillButton.text = "Skill" 
	
	skillButton.connect("pressed",self,"addSubClass", [player])
	skillButton.connect("mouse_entered",self,"handHover", [skillButton, hand])
	skillButton.connect("mouse_exited",self,"handHoverEnd",[skillButton, hand])
	
	
	
	attackButton.text = "Attack" 
	
	attackButton.connect("pressed",self,"playerAttack",[player])
	attackButton.connect("mouse_entered",self,"handHover", [attackButton, hand])
	attackButton.connect("mouse_exited",self,"handHoverEnd",[attackButton, hand])
	
	container.add_child(skillButton)
	container.add_child(attackButton)


func handHoverEnd(button, hand):
	 hand.visible = false

func handHover(button, hand):
	var position = button.get_position()
	hand.position.x = position.x + 40
	hand.position.y = position.y + 8
	hand.visible = true

func handHoverEnd2(button, hand):
	 hand.visible = false

func handHover2(button, hand):
	var position = button.get_position()
	var size = button.get_size()
	hand.position.x = position.x + 40 + size.x
	hand.position.y = position.y + 8 
	hand.visible = true



func backToActivity():
	var hand = $menu/subClass/subClassContainer/hand2
	hand.visible = false 
	var subClasses = $menu/subClass
	subClasses.visible = false 
	var skills = $menu/skillSelect
	skills.visible = false 
	var activity = $menu/actionSelect
	activity.visible = true

func addSubClass(player):
	var hand = $menu/subClass/subClassContainer/hand2
	var back = $menu/subClass/subClassBack
	back.connect("pressed",self,"backToActivity")
	var box = $menu/subClass
	box.visible = true
	var subClass = $menu/subClass/subClassContainer
	var actionSelect = $menu/actionSelect 
	for sClass in player.subClasses:
		var button = Button.new()
		button.text = sClass
		button.flat = true
		button.focus_mode = Control.FOCUS_NONE
		button.connect("pressed", self, "subClassSelected", [button, player])
		button.connect("mouse_entered", self,"handHover", [button, hand])
		button.connect("mouse_exited", self,"handHoverEnd",[button, hand])
		subClass.add_child(button)
	
	actionSelect.visible = false

func playerTurn(turnQue):
	print("Whose turn!")
	var whoseTurn = turnQue[0].type
	
	print("Current boss stat!")
	print(boss.shield) 
	print(boss.currentHP)
	print("Current boss stat!")
	statUpdate()
	if str(whoseTurn) == "fighter":
		var a = fighter.paladinSkills[0]
		fighter.applySkill(a)
		turnText.text = "Fighter's turn."
		fighter.turn()
		playerActivity(fighter)
	if str(whoseTurn) == "archer":
		turnText.text = "Archer's turn."
		archer.turn()
		playerActivity(archer)
	if str(whoseTurn) == "healer": 
		turnText.text = "Healer's turn."
		healer.turn()
		playerActivity(healer)
	if str(whoseTurn) == "caster":
		turnText.text = "Caster's turn."
		caster.turn()
		playerActivity(caster)
	turnQue.remove(0)

func next():
	if battleEnd == false:
		menuReset()
		statUpdate()
		if(turnQue.size() == 0):
			bossTurn()
			var t = Timer.new() 		# Create a new Timer node
			add_child(t)			# Add it to the node tree as the direct child
			t.start()			# Start it
			yield(t, "timeout")		# Finally, make the script stop with the yield
			yield(get_tree().create_timer(1),"timeout")
			roundStart()
		else: 
			playerTurn(turnQue)

# ==========================================================================================================
# ==========================================================================================================
# ==========================================================================================================
# ==========================================================================================================
#							ATTACKS 
# ==========================================================================================================
# ==========================================================================================================
# ==========================================================================================================
func playerAttack(player):
	print(boss.shield)
	if(boss.shield <= 0):
		boss.currentHP = boss.currentHP - (player.hit()) 
	else: 
		boss.shield = boss.shield - (player.hit()) 
		if(boss.shield < 0):
			var temp = abs(boss.shield)
			boss.currentHP = boss.currentHP - temp
	print("Player Attacks!")
	next()
func playerBuff(player,skill):
	if(skill.skill == "silence"):
		boss.silence = true
	next()
func skillSelected(player,button, skill):
	print("///////////// SKILL SELECT /////////////////////")
	turnText.text = button.text
	skill.skillTrack(player)
	skill.skillProcess(player)
	if(skill.attack == true): 
		playerAttack(player)
	elif (skill.bossDebuff == true):
		playerBuff(player,skill)
	else: 
		next()

func wait():
	var t = Timer.new() 		# Create a new Timer node
	add_child(t)			# Add it to the node tree as the direct child
	t.start()			# Start it
	yield(t, "timeout")		# Finally, make the script stop with the yield
	yield(get_tree().create_timer(1),"timeout")


func selectCharacter(player,button,skill):
	panel.visible = true
	print("&&&&&&&&&&&&&&&&&&&&&&&&&")
	print("Select A Char")
	print(fighter)
	print(caster)
	print(healer)
	print(archer)
	var f = $selectCharacter/fighterSelect
	f.connect("pressed",self,"charSelected", [player,skill,fighter]) 
	var h = $selectCharacter/healerSelect
	h.connect("pressed",self,"charSelected", [player,skill,healer])
	var c = $selectCharacter/casterSelect
	c.connect("pressed",self,"charSelected", [player,skill,caster])
	var a = $selectCharacter/archerSelect
	a.connect("pressed",self,"charSelected", [player,skill,archer])

func charSelected(player,skill,chara):
	print("Character has been selected!") 
	print(skill.skill)
	print(chara.type)
	skill.skillTrack(chara) 
	skill.effectedPlayer = chara
	skill.skillProcess(chara)
	next()

var turnBoss = 0
func bossTurn():
	$turnText.text = "Boss's Turn!"
	$menu/skillSelect.hide() 
	$selectCharacter.hide()
	$menu/actionSelect.hide()
	$menu/subClass.hide()
	var t = Timer.new() 		# Create a new Timer node
	add_child(t)			# Add it to the node tree as the direct child
	t.start()			# Start it
	yield(t, "timeout")		# Finally, make the script stop with the yield
	yield(get_tree().create_timer(1),"timeout")
	var c = boss.hit(partyAlive)
	$turnText.text = "Boss Hits: " + str(c)
	t = Timer.new() 		# Create a new Timer node
	add_child(t)			# Add it to the node tree as the direct child
	t.start()			# Start it
	yield(t, "timeout")		# Finally, make the script stop with the yield
	yield(get_tree().create_timer(2),"timeout")
	

	
	print("Bosses turn!")
# ==========================================================================================================
# ==========================================================================================================
# ==========================================================================================================
# ==========================================================================================================
# ==========================================================================================================
func animate(player):
	var charAnimate 
	if(str(player.type) == "fighter"):
		charAnimate = $fighter 
	if(str(player.type) == "caster"):
		charAnimate = $caster
	if(str(player.type) == "healer"):
		charAnimate = $healer
	if(str(player.type) == "archer"):
		charAnimate = $archer
	print(charAnimate)
	charAnimate.playing = true

func animateOff(player):
	var charAnimate 
	if(str(player.type) == "fighter"):
		charAnimate = $fighter 
	if(str(player.type) == "caster"):
		charAnimate = $caster
	if(str(player.type) == "healer"):
		charAnimate = $healer
	if(str(player.type) == "archer"):
		charAnimate = $archer
	print(charAnimate)
	charAnimate.playing = false

func statUpdate():
	if fighter.currentHP <= 0:
		fighter.alive = false 
		$fighter.animation = "dead" 
	else:
		$fighter.animation = "attack"
	if archer.currentHP <= 0:
		archer.alive = false 
		$archer.animation = "dead" 
	else:
		$archer.animation = "attack"
	
	if healer.currentHP <= 0: 
		healer.alive = false 
		$healer.animation = "dead"
	else: 
		$healer.animation = "attack" 
	
	if caster.currentHP <= 0:
		caster.alive = false 
		$caster.animation = "dead"
	else: 
		$caster.animation = "attack"
	
	if boss.currentHP <= 0:
		boss.alive = false
	
	if caster.alive == false && fighter.alive == false && archer.alive == false && healer.alive == false:
		battleFail()
		battleEnd = true
	if boss.alive == false:
		battleEnd()
		battleEnd = true
	var temp = 0
	$menu/playerHP/archer/archerName/health.text = "" + str(archer.currentHP) + "/" + str(archer.maxHP)
	$menu/playerHP/archer/archerHealth.value = archer.currentHP
	temp = archer.shield
	$menu/playerHP/archer/archerShield.value = temp
	$menu/playerHP/archer/archerHealth.max_value = archer.maxHP 
	$menu/playerHP/archer/archerHealth.min_value = 0
	$menu/playerHP/archer/archerShield.max_value = archer.maxShield 
	$menu/playerHP/archer/archerShield.min_value = 0
	
	$menu/playerHP/fighter/fighterName/health.text = "" + str(fighter.currentHP) + "/" + str(fighter.maxHP) 
	$menu/playerHP/fighter/fighterHealth.value = fighter.currentHP 
	temp = fighter.shield
	$menu/playerHP/fighter/fighterShield.value = temp
	$menu/playerHP/fighter/fighterHealth.max_value = fighter.maxHP 
	$menu/playerHP/fighter/fighterHealth.min_value = 0 
	$menu/playerHP/fighter/fighterShield.max_value = fighter.maxShield 
	$menu/playerHP/fighter/fighterShield.min_value = 0
	
	$menu/playerHP/healer/healerName/health.text = "" + str(healer.currentHP) + "/" + str(healer.maxHP)
	$menu/playerHP/healer/healerHealth.value = healer.currentHP 
	temp = healer.shield
	$menu/playerHP/healer/healerShield.value = temp
	$menu/playerHP/healer/healerHealth.max_value = healer.maxHP 
	$menu/playerHP/healer/healerHealth.min_value = 0 
	$menu/playerHP/healer/healerShield.max_value = healer.maxShield 
	print("$$$$$$$$$$$$$2392392292392903903")
	print(healer.maxShield)
	$menu/playerHP/healer/healerShield.min_value = 0 
	$menu/playerHP/caster/casterName/health.text = "" + str(caster.currentHP) + "/" + str(caster.maxHP)
	$menu/playerHP/caster/casterHealth.value = caster.currentHP 
	temp = caster.shield
	$menu/playerHP/caster/casterShield.value = temp
	$menu/playerHP/caster/casterHealth.max_value= caster.maxHP 
	$menu/playerHP/caster/casterHealth.min_value = 0 
	$menu/playerHP/caster/casterShield.max_value = caster.maxShield 
	$menu/playerHP/caster/casterShield.min_value = 0
	
	$menu/bossHP/boss/bossName/HP.text = "" + str(boss.currentHP) + "/" + str(boss.maxHP)
	$menu/bossHP/boss/bossHealth.value = boss.currentHP 
	$menu/bossHP/boss/bossHealth.max_value = boss.maxHP 
	$menu/bossHP/boss/bossHealth.min_value = 0
	temp = boss.shield
	$menu/bossHP/boss/bossShield.value = temp
	$menu/bossHP/boss/bossShield.max_value = boss.maxShield 
	$menu/bossHP/boss/bossShield.min_value = 0
	print("*************************")
	print("STATUS UPDATED")
	print("*************************")
func battleFail():
	$menu/skillSelect.hide() 
	$selectCharacter.hide()
	$menu/actionSelect.hide()
	$menu/subClass.hide()
	
	$battleEnd.show()
	$battleEnd/battleText.text = "Ooops. Battle Fail."
	print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
	print("Battle Fail!") 
	print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")

func battleEnd():
	$menu/skillSelect.hide() 
	$selectCharacter.hide()
	$menu/actionSelect.hide()
	$menu/subClass.hide()
	
	$battleEnd.show()
	$battleEnd/battleText.text = "Congradulations! Battle Won!"
	print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
	print("Battle End!") 
	print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")


func menuReset():
	panel.visible = false
	var action = $menu/actionSelect/actionSelectContainer.get_children()
	for clear in action:
		if clear.get_name() != "hand":
			clear.queue_free()
	var subClass = $menu/subClass/subClassContainer.get_children()
	for clear in subClass:
		if clear.get_name() != "hand2":
			clear.queue_free()
	var skills = $menu/skillSelect/scrollContainer/skillList/hand3.get_children()
	for clear in skills:
		if clear.get_name() != "hand3":
			clear.queue_free()