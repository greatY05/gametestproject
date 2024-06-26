extends Node2D

@onready var window = $Window

var pack = preload("res://scenes/window.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_button_pressed():
	add_child(pack)
	pack.position = $Button.position
