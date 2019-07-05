extends YSort

class_name TurnOrder

var battlersAlive : Battler
var action

func initialize():
	var battlers = getBattlers()
	battlers.sort_custom(self, 'sortBattlers')
	for battler in battlers:
		battler.raise()
	battlersAlive = get_child(0)
	emit_signal('queue_changed', getBattlers(), battlersAlive)

func playerTurn(action : CombatAction, targets : Array):
	if not action:
		yield(battlersAlive.skin.move_forward(), "completed")
	action.initialize(battlersAlive)
	var hit_target = yield(action.execute(targets), "completed")
	if not hit_target:
		action = true
		return
	action = false
	next()

func skip():
	next()

func next():
	var next_battler_index : int = (battlersAlive.get_index() + 1) % get_child_count()
	battlersAlive = get_child(next_battler_index)
	emit_signal('queue_changed', getBattlers(), battlersAlive)

static func sortBattlers(a : Battler, b : Battler) -> bool:
	return a.stats.speed > b.stats.speed

func getParty():
	return getMob(true)

func getMob():
	return getMob(false)

func getMob(in_party : bool = false) -> Array:
	var targets : Array = []
	for child in getChildren():
		if child.party_member == in_party && child.stats.health > 0:
			targets.append(child)
	return targets

func getBattlers():
	return getChildren()


