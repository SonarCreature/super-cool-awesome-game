extends Control

@onready var text = $MarginContainer/HBoxContainer/VBoxContainer/Options/Tuto
@onready var c2 = $MarginContainer/HBoxContainer/VBoxContainer/Options/ColorRect2
@onready var c1 = $MarginContainer/HBoxContainer/VBoxContainer/Options/ColorRect
@onready var c3 = $MarginContainer/HBoxContainer/VBoxContainer/Options/ColorRect3


func _ready():
	text.hide()
	c1.hide()
	c2.hide()
	c3.hide()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Levels/Board.tscn")


func _on_options_pressed():
	if (text.visible == true):
		text.visible = false
		c1.visible = false
		c2.visible = false
		c3.visible = false
	else:
		text.visible = true
		c1.visible = true
		c2.visible = true
		c3.visible = true



func _on_exit_pressed():
	get_tree().quit()
