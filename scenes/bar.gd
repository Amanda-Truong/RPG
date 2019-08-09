extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	diag()
	pass # Replace with function body.

func diag():
	var diagText = $textDiag
	var castSt = "Yay!"
	var fighterSt = "Let’s go help these poor people"
	var healerSt = "Why are you like this?"
	var archerSt = "...*sigh*..."
	var caster = $dialogue/caster
	var healer = $dialogue/healer
	var fighter = $dialogue/fighter
	var archer = $dialogue/archer
	fighter.show()
	diagText.text = "Fighter: "
	var temp
	var t = Timer.new() 		# Create a new Timer node
	add_child(t)			# Add it to the node tree as the direct child
	t.start()			# Start it
	yield(t, "timeout")		# Finally, make the script stop with the yield
	yield(get_tree().create_timer(0.4),"timeout")
	for letter in fighterSt: 
		var a = diagText.text
		diagText.text = ""
		diagText.text = str(a) + str(letter)
		yield(get_tree().create_timer(.1),"timeout")
	t = Timer.new() 		# Create a new Timer node
	add_child(t)			# Add it to the node tree as the direct child
	t.start()			# Start it
	yield(t, "timeout")		# Finally, make the script stop with the yield
	yield(get_tree().create_timer(1),"timeout")
	fighter.hide()
	healer.show()
	diagText.text = "Healer: "
	for letter in healerSt: 
		var a = diagText.text
		diagText.text = ""
		diagText.text = str(a) + str(letter)
		yield(get_tree().create_timer(.1),"timeout")
	t = Timer.new() 		# Create a new Timer node
	add_child(t)			# Add it to the node tree as the direct child
	t.start()			# Start it
	yield(t, "timeout")		# Finally, make the script stop with the yield
	yield(get_tree().create_timer(1),"timeout")
	healer.hide()
	archer.show()
	diagText.text = "Archer: "
	for letter in archerSt: 
		var a = diagText.text
		diagText.text = ""
		diagText.text = str(a) + str(letter)
		yield(get_tree().create_timer(.1),"timeout")