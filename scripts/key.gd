extends Area2D

signal follow

var isCollected
var speed

func _process(delta):
	if isCollected == true:
		global_position = global_position.lerp(global_position, speed*delta) 




