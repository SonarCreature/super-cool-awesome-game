extends Node2D

@export var map : TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	var used = map.get_used_cells(0)
	print(used)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if event is InputEventMouseButton:
		print("Mouse Click at:", event.position)
