extends Unit


# Called when the node enters the scene tree for the first time.
func _ready():
	hp = 7
	movement = 2
	
	#define abilities
	var bite = Ability.new()
	bite.description = "nomnomnomnomnom"
	bite.effect = "damage"
	bite.amount = 1
	bite.max_range = 1
	bite.name = "nomnom"
	bite.target = "enemy"
	var rahhhh = Ability.new()
	rahhhh.description = "run coward"
	rahhhh.effect = "damage"
	rahhhh.amount = 1
	rahhhh.target = "enemy"
	rahhhh.name = "rahhh"
	abilities.append(rahhhh)
	abilities.append(bite)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
