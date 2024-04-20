class_name Unit extends Node2D

@onready var controller = get_parent()
var board_position : Vector2i = Vector2i(0,0)
var movement = 3
var move_cells = []
var stop = 100
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
		else:
			controller.highlight_tile(cell)
	return move_cells

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
	if (cost > movement) || cell in controller.board.obstacles:
		return
	else:
		move_cells.append(cell)
		find_valid_movement(east, cost + get_cost(east))
		find_valid_movement(south, cost + get_cost(south))
		find_valid_movement(west, cost + get_cost(west))
		find_valid_movement(north, cost + get_cost(north))


func get_cost(cell : Vector2i):
	if cell in controller.board.map_data:
		return controller.board.get_cell_data(cell).move_cost
	return 9999

func get_move_cells():
	return move_cells

