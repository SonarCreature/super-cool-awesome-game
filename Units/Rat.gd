extends Unit


# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	team = 'enemy'
	hp = rng.randi_range(1, 7)
	enemy_damage = rng.randi_range(1, 3)
	var possible_frames = [101, 102, 103, 104, 113, 114, 115,  116, 117, 118, 123, 124, 125, 126, 127, 128, 129, 130]
	var chosen_frame = rng.randi_range(0, len(possible_frames) - 1)
	get_child(0).frame = possible_frames[chosen_frame]
	var names = ["Purple Rat", "Icy Rat", "Golden Rat", "Diseased Rat", "Pink Rat", "Albino Rat", "Highlighter Rat", "Blue Rat", "Edgy Rat", "Sandy Rat", "Rat", "Old Rat", "Red Rat", "Ourple Rat", "Weird Rat", "Lemon Rat", "Orange Rat", "Other Weird Rat"]
	unit_class = names[chosen_frame]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
