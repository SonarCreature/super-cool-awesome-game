extends Unit


# Called when the node enters the scene tree for the first time.
func _ready():
	hp = 2
	movement = 6
	unit_class = "Ghost"
	#define abilities
	var sword_slash = Ability.new()
	sword_slash.description = "A mid-range attack that does good damage"
	sword_slash.effect = "damage"
	sword_slash.amount = 5
	sword_slash.max_range = 2
	sword_slash.name = "Haunt"
	sword_slash.target = "enemy"
	var bolster = Ability.new()
	bolster.description = "Make yourself intangible, and take no damage"
	bolster.effect = "armor"
	bolster.amount = 10
	bolster.target = "self"
	bolster.name = "Incoporeate"
	abilities.append(sword_slash)
	abilities.append(bolster)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
