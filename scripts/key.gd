extends Area2D

var keyDest = false


func _on_key_sprite_animation_finished(destroy):
	if keyDest == false:
		keyDest = true
	else: print("already done")
