extends Node2D

@onready var doorCollision = $gate/gateArea



func _on_switch_area_area_entered(area):
	if area.name == "player" or area.name == "box":
		$switch/switchSprites.play("on")
		doorCollision.position.y += 1000
		$gate/gatesprites.play("open")
		print(doorCollision.position.y)


func _on_switch_area_area_exited(area):
	if area.name == "player" or area.name == "box":
		$switch/switchSprites.play("off")
		doorCollision.position.y -= 1000
		$gate/gatesprites.play("close")
		print(doorCollision.position.y)
