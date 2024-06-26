extends Node2D


@onready var box = $RigidBody2D
@onready var doorCollision = $gateArea
@onready var key = $key

var isCollected = false

func restart():
	get_tree().reload_current_scene()

const speed = 0.1
func _process(_delta):
	if isCollected == true:
		key.global_position = key.global_position.lerp($player/followPoint.global_position, speed) 
	if isCollected == false and gateUnlocked == true:
		key.global_position = key.global_position.lerp($lockedGate/unlockArea.global_position, speed) 
	
	if Input.is_key_pressed(KEY_R):
		restart()

var switchPressed = false
func _on_switch_body_entered(body):
	print($switch.get_overlapping_bodies())
	if body.name == "player" or body.name == "box":
		if switchPressed == false:
			switchPressed = true
			print(switchPressed)
			#3jesdfdjryhffhfhngdjdgngn
			$switch/switchSprite.play("on")
			$gateArea/doorCollision.set_deferred("disabled", true)
			$gateArea/gatesprites.play("open")


func _on_switch_body_exited(_body):
	print($switch.get_overlapping_bodies())
	if $switch.get_overlapping_bodies().size() < 1:
		switchPressed = false
		$switch/switchSprite.play("off")
		$gateArea/doorCollision.set_deferred("disabled", false)
		$gateArea/gatesprites.play("close")




func _on_key_body_entered(body):
	if body.name == "player":
		isCollected = true
		$key/keyColl.set_deferred("disabled", true)

var gateUnlocked = false
func _on_unlock_area_body_entered(_body):
	if isCollected == true:
		gateUnlocked = true
		isCollected = false
		$key/keySprite.play("RESET")
		$key.z_index += 1
		
		print("gate unlocked")
		await get_tree().create_timer(0.5).timeout
		$lockedGate/lockedGateColl.set_deferred("disabled", true)
		$Camera2D.shake()
		$key/keySprite.play("destroy")
		$key/keyColl/keyParticles.emitting = true
		$lockedGate/lockedGateColl/blocks/AnimationPlayer.play("keyinserted")
		#await $key/keySprite.finished("destroy")
		#$key.visible = false


func _on_flag_body_entered(body):
	if body.name == "player":
		get_tree().reload_current_scene()
