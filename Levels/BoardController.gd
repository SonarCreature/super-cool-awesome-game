extends Node2D

const UNIT_SCENE = preload("res://Units/Unit.tscn")
const BUILDING_SCENE = preload("res://Buildings/Building.tscn")
#idk why i have to access the board this way, but it works

const UNIT_TYPES : Dictionary = {
	"Knight" : preload("res://Units/Knight.tscn"), "Building" : preload("res://Buildings/Building.tscn")
}

#const BUILDING_TYPES : Dictionary = {
	#"placehlder!!" : preload("res://Building/buildingtypewahooo.tscn")
#}

@onready var board = get_parent()
var map_position : Vector2i
var active_unit : Unit

# Called when the node enters the scene tree for the first time.
func _init():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var new_position = board.get_map().local_to_map(get_global_mouse_position())
	update_cursor(new_position)
	if Input.is_action_just_pressed("left_click"):
		if new_position in board.map_data:
			if is_occupied(new_position):
				active_unit = board.get_cell_data(new_position).occupant
				active_unit.display_movement()
			else:
				if active_unit != null:
					print(active_unit.get_move_cells())
					try_move(active_unit, new_position)
					wipe_highlight()
		#print(board.get_cell_data(new_position).position)
	pass

func update_cursor(new_position):
	board.map.set_cell(2, map_position)
	map_position = new_position
	#Vector2 instead of 2i because its accessing a position in a tileset not worldspace
	board.map.set_cell(2, map_position, 0, Vector2(0,5))

func place_unit(position : Vector2i, type : String):
	if is_occupied(position) == true:
		print('tile is occupied')
		return
	
	var new_unit = UNIT_TYPES[type].instantiate()
	new_unit.name = "Unit"
	add_child(new_unit)
	new_unit.position = board.get_map().map_to_local(position)
	new_unit.board_position = position
	set_occupant(position, new_unit)

func place_building(position : Vector2i): # add type as param
	if is_occupied(position) == true:
		print('tile is occupied')
		return
	
	var new_building = BUILDING_SCENE.instantiate() # specific type
	new_building.name = "Building"
	add_child(new_building)
	new_building.position = board.get_map().map_to_local(position)
	new_building.board_position = position
	set_occupant(position, new_building)

func is_occupied(cell : Vector2i):
	return board.get_cell_data(cell).occupant != null

func set_occupant(cell : Vector2i, unit):
	board.get_cell_data(cell).occupant = unit

func highlight_tile(cell : Vector2i):
	board.map.set_cell(3, cell, 1, Vector2(1,2))

func try_move(unit, cell : Vector2i):
	
	if cell in unit.move_cells:
		set_occupant(unit.board_position, null)
		set_occupant(cell, unit)	
		unit.board_position = cell
		unit.position = board.get_map().map_to_local(cell)

func wipe_highlight():
	for cell in board.map_data:
		board.map.set_cell(3, cell, -1, Vector2(1,2))
	
