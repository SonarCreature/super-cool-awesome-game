extends Unit


# Called when the node enters the scene tree for the first time.
func _ready():
	hp = 4
	movement = 1
	
	var sword_slash = Ability.new()
	sword_slash.description = "A long range acid attack"
	sword_slash.effect = "damage"
	sword_slash.amount = 10
	sword_slash.max_range = 4
	sword_slash.name = "Acid Throw"
	sword_slash.target = "enemy"
	var bolster = Ability.new()
	bolster.description = "Heal an Adjacent Ally for 2 hp"
	bolster.effect = "health"
	bolster.amount = 2
	bolster.target = "player"
	bolster.name = "Reconstitute"
	abilities.append(sword_slash)
	abilities.append(bolster)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
