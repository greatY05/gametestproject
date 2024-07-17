extends Area2D

@onready var Tsprite = $trampoSprite



func _on_body_entered(body):
	if body is CharacterBody2D:
		Tsprite.play("off")
		Tsprite.play("active")
		print(body.velocity.y)
		body.jump(-600)
	if body is RigidBody2D:
		body.apply_central_force(Vector2(0, -400))

