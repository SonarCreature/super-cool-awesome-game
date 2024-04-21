extends Node2D

signal unit_selected
signal activate_ability(target)

const UNIT_SCENE = preload("res://Units/Unit.tscn")
const BUILDING_SCENE = preload("res://Buildings/Building.tscn")
#idk why i have to access the board this way, but it works

const UNIT_TYPES : Dictionary = {
	"Knight" : preload("res://Units/Knight.tscn"),
	"Rat" : preload("res://Units/Rat.tscn"),
	"Building" : preload("res://Buildings/Building.tscn"),
	"Barrel" : preload("res://Units/Barrel.tscn"),
	"Anvil" : preload("res://Units/Anvil.tscn"),
	"Tombstone" : preload("res://Units/Tombstone.tscn"),
	"Slime" : preload("res://Units/Slime.tscn"),
	"Skeleton" : preload('res://Units/Skeleton.tscn')
	
}

#const BUILDING_TYPES : Dictionary = {
	#"placehlder!!" : preload("res://Building/buildingtypewahooo.tscn")
#}
@onready var board = get_parent()
@export var ui : Control
@export var building_select : Control
@export var am : Node2D
@export var lose : Control
var map_position : Vector2i
var active_unit : Unit
var click_state = 'select'
var unit_nameplate
var unit_hp_disp
var playerUnits = []
var enemyUnits = []
var turn_num = 0
var unit_num = 0
var over_ui = false
var place_type
var wave_num = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	unit_nameplate = ui.get_child(0).get_child(0)
	unit_hp_disp = ui.get_child(0).get_child(1)	
	ui.get_child(2).pressed.connect(self._end_turn)
	ui.get_child(3).pressed.connect(self._quit)
	building_select.visible = false
	lose.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var new_position = board.get_map().local_to_map(get_global_mouse_position())
	update_cursor(new_position)
	if new_position in board.map.get_used_cells(0):
		if board.get_cell_data(new_position).occupant != null:
			unit_nameplate.text = board.get_cell_data(new_position).occupant.unit_class
			unit_hp_disp.text = "HP: "+str(board.get_cell_data(new_position).occupant.hp)
	if Input.is_action_just_pressed("left_click"):
		if over_ui == true:
			return
		if click_state == 'select':
			if new_position in board.map_data:
				if is_occupied(new_position):
					if board.get_cell_data(new_position).occupant.team == 'player':
						select(new_position)
				else:
					if active_unit != null:
						print(active_unit.get_move_cells())
						try_move(active_unit, new_position)
						wipe_highlight()
		if click_state == 'activate':
			activate_ability.emit(new_position)
		if click_state == 'place':
			if is_occupied(new_position) == true:
				return
			place_unit(new_position, place_type)
			click_state = 'select'
			spawn_wave()
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
	new_unit.name = "Unit" + str(unit_num)
	unit_num += 1
	add_child(new_unit)
	new_unit.position = board.get_map().map_to_local(position)
	new_unit.board_position = position
	if new_unit.getTeam() == "player":
		playerUnits.append(new_unit)
	else:
		enemyUnits.append(new_unit)
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
		unit.has_moved = true
	else:
		deselect()

func force_move(unit, cell : Vector2i):
		if board.get_cell_data(cell).occupant != null:
			return
		set_occupant(unit.board_position, null)
		set_occupant(cell, unit)	
		unit.board_position = cell
		unit.position = board.get_map().map_to_local(cell)

func wipe_highlight():
	for cell in board.map_data:
		board.map.set_cell(3, cell, -1, Vector2(1,2))

func select(unit : Vector2i):
	active_unit = board.get_cell_data(unit).occupant
	unit_selected.emit()
	if active_unit.has_moved == false:
		active_unit.display_movement()

func deselect():
	active_unit.move_cells = []
	active_unit = null
	ui.get_child(1).visible = false
	wipe_highlight()

func _end_turn():
	turn_num += 1
	if playerUnits.size() == 0:
		lose.visible = true
		return
	if enemyUnits.size() != 0:
		for i in enemyUnits.size():
			enemyUnits[i].getAIMVMT(enemyUnits[i].getboardpos())
	else:
		new_wave()
	for i in playerUnits:
		i.has_moved = false
		i.has_acted = false
		i.armor = 0
	am.active_ability = null
	ui.get_child(1).visible = false
	print(turn_num)

func _on_control_entered():
	print('entered')
	over_ui = true
	pass # Replace with function body.

func _on_control_exited():
	print('exited')	
	over_ui = false
	pass # Replace with function body.

func new_wave():
	wave_num += 1
	building_select.visible = true

func spawn_wave():
	var rng = RandomNumberGenerator.new()
	var to_spawn = wave_num + 2
	while to_spawn != 0:
		var tile = board.map.get_used_cells(0)[rng.randi_range(0, board.map.get_used_cells(0).size()-10)]
		if tile not in board.obstacles && board.get_cell_data(tile).occupant == null:
			place_unit(tile, "Rat")
			to_spawn -= 1
	for unit in playerUnits:
		if unit.unit_class == "Barrel":
			try_place("Slime", unit.board_position)
		if unit.unit_class == "Tombstone":
			try_place("Skeleton", unit.board_position)

func try_place(type : String, cell : Vector2i):
	var north = Vector2i(cell.x, cell.y - 1)
	var south = Vector2i(cell.x, cell.y + 1)
	var east = Vector2i(cell.x + 1, cell.y)
	var west = Vector2i(cell.x - 1, cell.y)
	var to_try = [north, south, east, west]
	for tile in to_try:
		if board.get_cell_data(tile).occupant == null && tile not in board.obstacles:
			place_unit(tile, type)
			return

func _on_select_barrel_pressed():
	begin_placement('Barrel')
	pass # Replace with function body.

func _on_select_anvil_pressed():
	begin_placement('Anvil')	
	pass # Replace with function body.

func _on_select_tombstone_pressed():
	begin_placement('Tombstone')	
	pass # Replace with function body.

func begin_placement(type : String):
	building_select.visible = false
	click_state = 'place'
	place_type = type

func _quit():
	get_tree().quit()


func _on_button_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.
