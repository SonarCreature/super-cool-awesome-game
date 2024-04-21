extends Control

signal entered
signal exited

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function bo

func entered_ui():
	entered.emit()

func exited_ui():
	exited.emit()

func _on_abilities_mouse_entered():
	entered_ui()
	pass # Replace with function body.

func _on_abilities_mouse_exited():
	exited_ui()
	pass # Replace with function body.
