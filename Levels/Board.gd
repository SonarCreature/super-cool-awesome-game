extends Node2D

#import resources
@export var map : TileMap
var map_data : Dictionary = {}
var obstacles = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var cells = map.get_used_cells(0)
	obstacles = map.get_used_cells(1)
	for cell in cells:
		map_data[cell] = CellData.new()
		map_data[cell].position = cell
	get_child(2).place_unit(Vector2i(5,5), "Knight")
	get_child(2).place_unit(Vector2i(20,6), "Rat")	
	
	
	
	#get_child(1).place_unit(Vector2i(5,7), "Building")
	pass # Replace with function body.

func get_cell_data(cell : Vector2i):
	return map_data[cell]
	
func get_map():
	return map
