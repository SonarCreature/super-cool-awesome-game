extends Node2D

@export var controller : Node2D
@export var ui : Control
var ability_buttons = []
var valid_targets = []
var active_ability
var ability_panel
# Called when the node enters the scene tree for the first time.
func _ready():
	ability_panel = ui.get_child(1)
	ability_buttons = ui.get_child(1).get_children()
	ability_buttons[0].pressed.connect(self._load_ability1)
	ability_buttons[1].pressed.connect(self._load_ability2)
	ability_panel.visible = false
	
	pass # Replace with function body.

func update_ui(unit):
	ability_panel.visible = true
	ability_buttons[0].text = unit.abilities[0].name
	ability_buttons[1].text = unit.abilities[1].name
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _load_ability1():
	load_ability(controller.active_unit.abilities[0], controller.active_unit.board_position)

func _load_ability2():
	load_ability(controller.active_unit.abilities[1], controller.active_unit.board_position)
	
func load_ability(ability : Ability, unit):
	if controller.active_unit.has_acted == true:
		return
	controller.click_state = 'activate'
	controller.wipe_highlight()
	valid_targets = get_valid_targets(ability.max_range, ability.target, unit)
	for target in valid_targets:
		controller.highlight_tile(target)
	active_ability = ability
	pass

func _on_board_controller_unit_selected():
	update_ui(controller.active_unit)
	pass # Replace with function body.

func get_valid_targets(range : int, target_type : String, unit : Vector2i):
	var valid_targets = []
	if target_type == 'self':
		valid_targets.append(unit)
		return valid_targets
	var to_search = controller.active_unit.find_range(range)
	for cell in to_search:
		if controller.board.get_cell_data(cell).occupant != null:
			if controller.board.get_cell_data(cell).occupant.team == target_type:
				valid_targets.append(cell)
	return valid_targets


func _on_board_controller_activate_ability(target):
	activate_ability(target, active_ability.effect, active_ability.amount)
	controller.wipe_highlight()
	controller.click_state = 'select'
	pass # Replace with function body.

func activate_ability(target_cell : Vector2i, effect : String, value : int):
	if controller.board.get_cell_data(target_cell).occupant == null:
		return
	var target = controller.board.get_cell_data(target_cell).occupant
	if effect == 'damage':
		target.take_damage(value)
	if effect == "armor":
		target.add_armor(value)
	if effect == "health":
		target.heal(value)
	controller.active_unit.has_acted = true
