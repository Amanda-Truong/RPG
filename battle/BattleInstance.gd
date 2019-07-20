extends Node


var battleEnd = false 

var party = []
 
var win
var fail

var turnQue = []


var fighter 
var archer 
var healer 
var caster 

var boss 

signal whoseTurn
func _ready():
	print("Start Battle Instance")
	
	
	#TEST JUNK 
	#TEST JUNK END 
	
	fighter = preload("res://skills/character/fighter/fighter.gd").new()
	fighter._ready()
	archer =  preload("res://skills/character/archer/archer.gd").new()
	archer._ready()
	healer = preload("res://skills/character/healer/healer.gd").new()
	healer._ready()
	caster = preload("res://skills/character/caster/caster.gd").new()
	caster._ready()
	party = [fighter, archer, caster, healer]  
	boss = preload("res://skills/boss/tree.gd").new()  
	boss._ready()
	
	setCharacterNames()
	roundStart()
	next()

func setCharacterNames():
	var charInfo = load("res://data/character/CharacterInfo.gd")
	charInfo = charInfo.new() 
	charInfo.characterNames()
	fighter.fighterName = charInfo.fighterName 
	archer.archerName = charInfo.archerName 
	healer.healerName = charInfo.healerName 
	caster.casterName = charInfo.casterName 


func subClassSelected(button, player):
	var subClass = button.text
	subClass = subClass.to_lower()
	var skills = $menu/skillSelect/scrollContainer/skillList
	var clearSkills = skills.get_children()
	for clear in clearSkills:
		if clear.get_name() != "hand3":
			clear.free()
	addSkills(player, player.getSkill(subClass))


func roundStart():
	var rounds = 0 
	print("Top of the Round")
	turnQue = [] + party


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
		button.text = skill.skillName
		button.flat = true
		button.focus_mode = Control.FOCUS_NONE
		button.connect("pressed",self,"skillSelected", [button])
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
	
	var whoseTurn = turnQue[0].type
	if str(whoseTurn) == "fighter":
		print(fighter.fighterName) 
		playerActivity(fighter)
	if str(whoseTurn) == "archer":
		print(archer.archerName)
		playerActivity(archer)
	if str(whoseTurn) == "healer": 
		print(healer.healerName)
		playerActivity(healer)
	if str(whoseTurn) == "caster":
		print(caster.casterName)
		playerActivity(caster)
	turnQue.remove(0)

func next():
	menuReset()
	if(turnQue.size() == 0):
		bossTurn()
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
	var att = player.attack()
	boss.hp = boss.hp - att
	print("Player Attacks!")
	next()

func skillSelected(button):
	print(button.text)
	next()

func bossTurn():
	print(boss.hp)
	
# ==========================================================================================================
# ==========================================================================================================
# ==========================================================================================================
# ==========================================================================================================
# ==========================================================================================================

func menuReset():
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