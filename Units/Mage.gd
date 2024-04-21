extends Unit


# Called when the node enters the scene tree for the first time.
func _ready():
	hp = 5
	movement = 3
	
	#define abilities
	var fire_ball = Ability.new()
	fire_ball.description = "Fire a powerfull ball of fire that deals moderate damage to the victim and those close by"
	fire_ball.effect = "damage"
	fire_ball.amount = 3
	fire_ball.max_range = 3
	fire_ball.name = "fire"
	fire_ball.target = "enemy"
	var lightning_strike = Ability.new()
	lightning_strike.description = "Attack with a bolt of lightning dealing high damage with long range"
	lightning_strike.effect = "damage"
	lightning_strike.amount = 6
	lightning_strike.max_range = 8
	lightning_strike.target = "enemy"
	lightning_strike.name = "lightning"
	abilities.append(fire_ball)
	abilities.append(lightning_strike)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
