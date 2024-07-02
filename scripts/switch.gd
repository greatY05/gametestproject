extends Area2D

@export var door : Node2D
var switchPressed = false
#signal pressed(id: int)

func _on_body_entered(body):
	print(get_overlapping_bodies())
	if body.name == "player" or body.name == "box":
		if switchPressed == false:
			switchPressed = true
			print(switchPressed)
			$switchSprite.play("on")
			#$gateArea/doorCollision.set_deferred("disabled", true)
			#$gateArea/gatesprites.play("open")
			door.changeState()


func _on_body_exited(body):
	print(get_overlapping_bodies())
	print(get_overlapping_bodies())
	if get_overlapping_bodies().size() < 1:
		switchPressed = false
		$switchSprite.play("off")
		#$gateArea/doorCollision.set_deferred("disabled", false)
		#$gateArea/gatesprites.play("close")
		door.changeState()
