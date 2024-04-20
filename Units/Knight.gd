extends Unit


# Called when the node enters the scene tree for the first time.
func _ready():
	hp = 7
	movement = 2
	
	#define abilities
	var sword_slash = Ability.new()
	sword_slash.description = "A 1-tile range slash that deals 3 damage to enemies"
	sword_slash.effect = "damage"
	sword_slash.amount = 3
	sword_slash.max_range = 1
	sword_slash.name = "Slash"
	sword_slash.target = "enemy"
	var bolster = Ability.new()
	bolster.description = "Steel yourself, and gain 1 temporary armor"
	bolster.effect = "armor"
	bolster.amount = 1
	bolster.target = "self"
	bolster.name = "bolster"
	abilities.append(sword_slash)
	abilities.append(bolster)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
