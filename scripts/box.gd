extends CharacterBody2D

@export var gravity = 500

var Velocity = Vector2.ZERO

func _physics_process(delta):
	velocity.y += gravity
	
	Velocity = move_and_slide()
	velocity = Vector2.ZERO
	

func slide(vector):
	velocity.x = vector.x 
