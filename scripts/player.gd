extends CharacterBody2D

@export var jumpHeight : float
@export var jumpTimePeak : float
@export var jumpTimeDescent : float

@onready var jumpVel : float  = ((2 * jumpHeight) / jumpTimePeak) * -1.0
@onready var jumpGrav : float = ((-2.0 * jumpHeight) / (jumpTimePeak * jumpTimePeak))* -1.0
@onready var fallGrav : float = ((-2.0 * jumpHeight) / (jumpTimeDescent * jumpTimeDescent))* -1.0


@export var SPEED = 300.0
const JUMP_VELOCITY = -300.0
@onready var animPlayer = $AnimationPlayer
@onready var animSprite = $AnimatedSprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var push_force = 30
# Get the gravity from the project settings to be synced with RigidBody nodes.

func get_gravity() -> float:
	return jumpGrav if velocity.y < 0 else fallGrav

func jump():
	velocity.y = jumpVel

func _physics_process(delta):
	velocity.y += get_gravity() * delta
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
	
	## Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump()
	#
	if Input.is_action_pressed("left"):
		animSprite.flip_h = false
		$followPoint.position.x = 20
	elif Input.is_action_pressed("right"):
		animSprite.flip_h = true
		$followPoint.position.x = -20
	## Get the input direction and handle the movement/deceleration.
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
	## As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		
		animSprite.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animSprite.play("idle")

	move_and_slide()
	#handles key follwing you around and hopefully other items in the future
	if pickupfollow == true:
		for i in collectedItems:
			#print(i)
			i.global_position = i.global_position.lerp($followPoint.global_position, pickupSpeed*delta)
	

var pickupSpeed = 5
var pickupfollow = false

var collectedItems : Array

func _on_pickup_area_area_entered(area):
	print("new?")
	#currently only accepts key due to me not messing with collision layers rn, but a collision layer should handle pickups instead
	if area.name not in collectedItems and area.is_in_group("pickup"):
		collectedItems.append(area)
		print(collectedItems)
		pickupfollow = true
		area.get_node("keyColl").set_deferred("disabled", true)
		
		#await Engine.get_main_loop().process_frame
		#area.reparent(self)
		
		#print("added child - ", area, " to myself ", self)
		#area.isCollected = true




