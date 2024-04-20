extends Node2D

#import resources
const unit_scene = preload("res://Units/Unit.tscn")

@export var map : TileMap
@export var basic_unit : Unit

@export var map_data : Dictionary = {}
var map_position : Vector2i
# Called when the node enters the scene tree for the first time.
func _ready():
	var cells = map.get_used_cells(0)
	for cell in cells:
		map_data[cell] = cellData.new()
		map_data[cell].position = cell
	print(map_data[Vector2i(0,1)].position)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var new_position = map.local_to_map(get_global_mouse_position())
	update_cursor(new_position)
	if Input.is_action_just_pressed("left_click"):
		print(get_cell_data(new_position).position)
	pass

func update_cursor(new_position):
	map.set_cell(2, map_position)
	map_position = new_position
	#Vector2 instead of 2i because its accessing a position in a tileset not worldspace
	map.set_cell(2, map_position, 0, Vector2(0,5))

func create_unit(position : Vector2i):
	var unit_cell = map.get_cell_tile_data(0, position)
	print(unit_cell.get_custom_data('Occupant'))
	if unit_cell.get_custom_data('Occupant') != null:
		print('cell is occupied')
		return
	
	var new_unit_scene = unit_scene.instantiate()
	new_unit_scene.set_name("Unit")
	add_child(new_unit_scene)
	new_unit_scene.position = map.map_to_local(position)
	
	unit_cell.set_custom_data('Occupant', new_unit_scene)
	
func get_cell_data(cell : Vector2i):
	return map_data[cell]
