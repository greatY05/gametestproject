extends StaticBody2D

@onready var gatesprites = $gatesprites
@onready var doorcollision = $doorCollision

func changeState():
	if doorcollision.disabled:
		gatesprites.play("close")
		doorcollision.set_deferred("disabled", false)
	elif !doorcollision.disabled:
		gatesprites.play("open")
		doorcollision.set_deferred("disabled", true)
	
