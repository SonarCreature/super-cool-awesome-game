class_name Unit extends Node2D

@onready var controller = get_parent()
var board_position : Vector2i = Vector2i(0,0)
var turnTaken = false
var movement = 3
var augment = 0
var armor = 0
var move_cells = []
var team = 'player'
var hp = 5
var acted = false
var abilities = []
var selection = 0
var mvmtSelection = Vector2i(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func display_movement():
	move_cells = []
	find_valid_movement(board_position, 0)
	#print(move_cells)
	for cell in move_cells:
		if cell == board_position:
			move_cells.erase(cell)
	for cell in move_cells:
		controller.highlight_tile(cell)
	return move_cells

func find_range(range):
	find_neareast()
	
	var temp = []
	find_valid_range(board_position, 0, range, temp)
	
	for cell in temp:
		if cell in controller.board.obstacles:
			temp.erase(cell)
	return temp

func find_valid_movement(cell : Vector2i, cost : int):
	var north = Vector2i(cell.x, cell.y - 1)
	var south = Vector2i(cell.x, cell.y + 1)
	var east = Vector2i(cell.x + 1, cell.y)
	var west = Vector2i(cell.x - 1, cell.y)
	if (cell in move_cells)==true:	
		if (north in move_cells)==true:
			if (south in move_cells)==true:
				if (east in move_cells) == true:
					if (west in move_cells)==true:
						return
	if (cost > movement) || cell in controller.board.obstacles || (controller.board.get_cell_data(cell).occupant != null && cell != board_position):
		return
	else:
		move_cells.append(cell)
		find_valid_movement(east, cost + get_cost(east))
		find_valid_movement(south, cost + get_cost(south))
		find_valid_movement(west, cost + get_cost(west))
		find_valid_movement(north, cost + get_cost(north))

func find_valid_range(cell : Vector2i, cost : int, range : int, final_array : Array):
	var north = Vector2i(cell.x, cell.y - 1)
	var south = Vector2i(cell.x, cell.y + 1)
	var east = Vector2i(cell.x + 1, cell.y)
	var west = Vector2i(cell.x - 1, cell.y)
	if (cell in final_array)==true:	
		if (north in final_array)==true:
			if (south in final_array)==true:
				if (east in final_array) == true:
					if (west in final_array)==true:
						return
	if (cost > range):
		return
	else:
		final_array.append(cell)
		find_valid_range(east, cost + 1, range, final_array)
		find_valid_range(south, cost + 1, range, final_array)
		find_valid_range(west, cost + 1, range, final_array)
		find_valid_range(north, cost + 1, range, final_array)


func get_cost(cell : Vector2i):
	
	if cell in controller.board.map_data:
		return controller.board.get_cell_data(cell).move_cost
	return 9999

func get_move_cells():
	return move_cells
	
func get_hp():
	return hp
func get_action():
	return abilities[selection].ammount
func take_damage(damage: int ):
	hp = hp - augCalc(damage)
	if hp <= 0:
		get_node(".").queue_free()
func heal(damage: int):
	hp = hp + damage
func armorCalc(damage:int):
	return damage-armor
func damageBuff(damage: int):
	return damage+augment
func augCalc(damage:int):
	damage = damage-armor
	damage = damage+augment
	return damage
func add_armor(amount : int):
	armor += amount
func find_neareast():
	print(controller.playerUnits[0].getboardpos())
	var closee = controller.playerUnits[0].getboardpos()
	var lowest = 10
	var lowast = controller.playerUnits[0].getboardpos()
	var gap = Vector2i(0,0)
	var gaq = 0
	for i in controller.playerUnits.size():
		gap =controller.playerUnits[i].getboardpos() - board_position
		gaq = gap.x + gap.y 
		if gaq < lowest:
			lowast = controller.playerUnits[i].getboardpos()
			lowest = gaq
	return lowast
func getAIMVMT(position : Vector2i):
	find_valid_movement(position,0)
	var nearby = find_neareast()
	print("nearby: ",nearby)
	var nearbyiest = board_position
	var gap = Vector2i(0,0)
	var gaq = 0
	var shortest = 10000
	for cell in move_cells:
		print("cell: ",cell)
		gap = nearby - cell
		gaq = abs(gap.x) + abs(gap.y)
		print("gaq: ",gaq)
		print("gap: ",gap)
		print ("shortest: ", shortest)
		if (abs(gaq)<shortest):
			nearbyiest = cell
			shortest = abs(gaq)
	mvmtSelection = nearbyiest
	print("nearby: ",nearbyiest)
	controller.force_move(controller.board.get_cell_data(board_position).occupant, nearbyiest)
func getTeam():
	return team
func getboardpos():
	return board_position



