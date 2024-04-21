extends Unit


# Called when the node enters the scene tree for the first time.
func _ready():
	team = 'enemy'
	hp = 3
	
	var bite = Ability.new()
	bite.effect = "damage"
	bite.amount = 1
	bite.max_range = 1
	bite.name = "Bite"
	bite.target = "player"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
