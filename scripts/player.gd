extends CharacterBody2D

@export var jumpHeight : float
@export var jumpTimePeak : float
@export var jumpTimeDescent : float

@onready var jumpVel : float  = ((2 * jumpHeight) / jumpTimePeak) * -1.0
@onready var jumpGrav : float = ((-2.0 * jumpHeight) / (jumpTimePeak * jumpTimePeak))* -1.0
@onready var fallGrav : float = ((-2.0 * jumpHeight) / (jumpTimeDescent * jumpTimeDescent))* -1.0


@export var SPEED = 100.0
const JUMP_VELOCITY = -300.0
@onready var animPlayer = $AnimationPlayer
@onready var animSprite = $AnimatedSprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var push_force = 30
# Get the gravity from the project settings to be synced with RigidBody nodes.

func get_gravity() -> float:
	return jumpGrav if velocity.y < 0 else fallGrav

func jump(Jvel):
	print(Jvel)
	velocity.y = Jvel


#stuff for pushable objects
@export var pushForce = 15


func _physics_process(delta):
	velocity.y += get_gravity() * delta
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
	
	#Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump(jumpVel)
	#
	if Input.is_action_pressed("left"):
		animSprite.flip_h = false
		$followPoint.position.x = 20
	elif Input.is_action_pressed("right"):
		animSprite.flip_h = true
		$followPoint.position.x = -20
	
	
	# Get the input direction and handle the movement/deceleration.
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is CharacterBody2D:
			c.get_collider().slide(-c.get_normal() * pushForce * (SPEED/15))
		
		
	## As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		
		animPlayer.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animPlayer.play("idle")

	move_and_slide()
	#handles key follwing you around and hopefully other items in the future
	
	if pickupfollow == true:
		for i in collectedItems:
			#var dist = sqrt(abs(self.position.x - i.position.x)+abs(self.position.y - i.position.y))
			#if dist < 3:
				#dist = lerpf(dist, 0, 0.5)
			i.global_position = i.global_position.lerp($followPoint.global_position, pickupSpeed*delta)
			#if $dontMove in i.get_overlapping_areas():
				#print("wow")
				#i.global_position = i.global_position.lerp(i.global_position, pickupSpeed*delta)
			#var i = collectedItems[l]
			#var distOld = distArr[l][0]
			#var relOldPos = distArr[l][1]
			#print(i)
			#var rad = 3
			#var dist = sqrt(abs(self.position.x - i.position.x)+abs(self.position.y - i.position.y))
#
			#var m = (i.position.y-self.position.y)/(i.position.x-self.position.x)
			#var angle = atan(m)
			#var relPosition = Vector2(rad*cos(angle), rad*sin(angle))
			#relPosition.x = relPosition.x * -1 if i.position.x < self.position.x else relPosition.x
			#relPosition.y = relPosition.y * -1 if i.position.y < self.position.y else relPosition.y
			#
			#if distOld>dist:
				#dist = distOld
				#relPosition = relOldPos
			#else:
				#distArr[l][0] = dist
				#relPosition = relPosition*15/2.5 + global_position
				#distArr[l][1] = relPosition
				#
			#print(dist)
			
			#var p = new Vector2()
			

			#i.global_position = i.global_position.lerp(relPosition, pickupSpeed*delta)
	

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


