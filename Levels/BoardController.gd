extends Node2D

const unit_scene = preload("res://Units/Unit.tscn")
#idk why i have to access the board this way, but it works
@onready var board = get_parent()
var map_position : Vector2i

# Called when the node enters the scene tree for the first time.
func _init():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var new_position = board.get_map().local_to_map(get_global_mouse_position())
	update_cursor(new_position)
	if Input.is_action_just_pressed("left_click"):
		if is_occupied(new_position):
			var unit = board.get_cell_data(new_position).occupant
			unit.display_movement()
		#print(board.get_cell_data(new_position).position)
	pass

func update_cursor(new_position):
	board.map.set_cell(2, map_position)
	map_position = new_position
	#Vector2 instead of 2i because its accessing a position in a tileset not worldspace
	board.map.set_cell(2, map_position, 0, Vector2(0,5))

func place_unit(position : Vector2i):
	if is_occupied(position) == true:
		print('tile is occupied')
		return
	
	var new_unit = unit_scene.instantiate()
	new_unit.name = "Unit"
	add_child(new_unit)
	new_unit.position = board.get_map().map_to_local(position)
	new_unit.board_position = position
	set_occupant(position, new_unit)

func is_occupied(cell : Vector2i):
	return board.get_cell_data(cell).occupant != null

func set_occupant(cell : Vector2i, unit):
	board.get_cell_data(cell).occupant = unit

func highlight_tile(cell : Vector2i):
	board.map.set_cell(2, cell, 1, Vector2(1,2))
