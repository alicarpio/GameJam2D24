class_name MainMenu
extends Control

@onready var start_button =$MarginContainer/HBoxContainer/VBoxContainer/Start_Button as Button
@onready var exit_button =$MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button
@onready var start_level = preload("res://Main_Menu/main_menu.tscn") 



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
