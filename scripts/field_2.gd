extends Node2D

@onready var window = $Window

var pack = preload("res://scenes/window.tscn").instantiate()


func _on_button_pressed():
	add_child(pack)
	pack.position = $Button.position
