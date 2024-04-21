extends Node2D

@export var controller : Node2D
@export var ui : Control
var ability_buttons = []
# Called when the node enters the scene tree for the first time.
func _ready():
	ability_buttons = ui.get_child(1).get_children()
	ability_buttons[0].pressed.connect(self._load_ability1)
	ability_buttons[1].pressed.connect(self._load_ability2)
	pass # Replace with function body.

func update_ui(unit):
	ability_buttons[0].text = unit.abilities[0].name
	ability_buttons[1].text = unit.abilities[1].name
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _load_ability1():
	load_ability(controller.active_unit.abilities[0], controller.active_unit)

func _load_ability2():
	load_ability(controller.active_unit.abilities[1], controller.active_unit)
	
func load_ability(ability : Ability, unit):
	pass

func _on_board_controller_unit_selected():
	update_ui(controller.active_unit)
	pass # Replace with function body.
