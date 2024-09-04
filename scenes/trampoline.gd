extends Area2D

@onready var Tsprite = $trampoSprite


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is CharacterBody2D:
		Tsprite.play("off")
		Tsprite.play("active")
		print(body.velocity.y)
		body.jump(-600)
	if body is RigidBody2D:
		body.apply_impulse(Vector2(0,-400))
