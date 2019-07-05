extends Node2D

class_name BattleInstance

 var turns : TurnQueue = $TurnQueue
 var scene = $BattleScene
 var drops = $drops

var active : bool = false
var party : Array = []
var turnOrder : TurnOrder


var ko
var win
var fail

func initialize(TurnOrder : TurnOrder, party : Array):
	turnOrder = TurnOrder
	startOrder(TurnOrder, party)
		
	var battlers = turns.getBattlers()
	for battler in battlers:
		battler.initialize()
		
	scene.initialize(self, turns, battlers)
	drops.initialize(battlers)
	turns.initialize()
	
func start():
	active = true
	playerTurn()

func startOrder(TurnOrder : TurnOrder, playerChars : Array):
	
	for enemy_template in TurnOrder.get_children():
		var enemy : Battler = enemy_template.duplicate()
		turns.add_child(enemy)
		enemy.stats.reset() 
	
	var partyPosition = $SpawnPositions/Party
	for i in len(playerChars):
		var playerMember = playerChars[i]
		var position = partyPosition.get_child(i)
		var battler : Battler = playerMember.get_battler_copy()
		battler.position = position.position
		battler.name = playerMember.name
		battler.set_meta("playerMember", playerMember)
		turns.add_child(battler)
		self.party.append(battler)
		
		battler.ai.set("scene", scene)

func ko():
	active = false
	var active_battler = getBattlers()
	active_battler.selected = false
	var player_won = active_battler.playerMember
	if player_won:
		win = true
		yield(drops.on_ko(), "completed")
		ko = true
	else:
		fail = true
		
	
func playerTurn():
	var battler : Battler = getBattlers()
	var targets : Array
	var action : CombatAction

	while not battler.is_able_to_play():
		turns.skip_turn()
		battler = getBattlers()

	battler.selected = true
	var opponents : Array = getOrder()
	if not opponents:
		ko()
		return

	action = yield(battler.ai.choose_action(battler, opponents), "completed")
	targets = yield(battler.ai.choose_target(battler, action, opponents), "completed")
	battler.selected = false
	
	if targets != []:
		yield(turns.playerTurn(action, targets), "completed")
	if active:
		playerTurn()

func getBattlers() -> Battler:
	return turns.active_battler

func getOrder() -> Array:
	if getBattlers().playerMember:
		return turns.get_monsters()
	else:
		return turns.get_party()
