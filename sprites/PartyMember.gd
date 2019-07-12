signal levelUp(new_value, old_value)

export var level : Level

export var storyLevel : int setget setStoryLevel
var stats : Level

onready var battler : Battler = $Battler
onready var SAVE_KEY : String = "party_member_" + name

func _ready():
	assert level
	stats = level.createStat(storyLevel)
	battler.stats = stats

func update(before_stats : CharacterStats):

	var previous = before_stats.level
	var new = level.getLevel(storyLevel)
	if previous != new:
		stats = level.createStat(storyLevel)
		emit_signal("levelUp", new, previous)
	battler.stats = stats

func setStoryLevel(value : int):
	if value == null:
		return
	storyLevel = max(0, value)
	if stats:
		update(stats)

func save(save_game : Level):
	save_game.data[SAVE_KEY] = {
		'storyLevel' : storyLevel,
		'hp' : stats.hp,
		'skills' : stats.skills
		'gear' : stats.gear,
	}

func load(save_game : Level):
	var data : Dictionary = save_game.data[SAVE_KEY]
	storyLevel = data['storyLevel']
	stats.hp = data['hp']
	stats.gear = data['gear']
	stats.skills = data['skills']
