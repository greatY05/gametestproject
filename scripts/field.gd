extends Node2D


@onready var box = $box
@onready var doorCollision = $gateArea
@onready var key = $key
@onready var switch = $switch
var switchId = 0


var isCollected = false

var newSwitch = preload("res://scenes/switch.tscn")
var newSwitchScript = preload("res://scripts/switch.gd")


func restart():
	get_tree().reload_current_scene()

const speed = 5
func _process(delta):
	#if isCollected == true:
		#key.global_position = key.global_position.lerp($player/followPoint.global_position, speed*delta) 
	if gateUnlocked == true:
		key.global_position = key.global_position.lerp($lockedGate/unlockArea.global_position, speed*delta) 
	if Input.is_key_pressed(KEY_R):
		restart()



#var switchPressed = false
#func _on_switch_body_entered(body):
	#print($switch.get_overlapping_bodies())
	#if body.name == "player" or body.name == "box":
		#if switchPressed == false:
			#switchPressed = true
			#print(switchPressed)
			##3jesdfdjryhffhfhngdjdgngn
			#$switch/switchSprite.play("on")
			#$gateArea/doorCollision.set_deferred("disabled", true)
			#$gateArea/gatesprites.play("open")
#
#
#func _on_switch_body_exited(_body):
	#print($switch.get_overlapping_bodies())
	#if $switch.get_overlapping_bodies().size() < 1:
		#switchPressed = false
		#$switch/switchSprite.play("off")
		#$gateArea/doorCollision.set_deferred("disabled", false)
		#$gateArea/gatesprites.play("close")

var pack = preload("res://scenes/window.tscn")

func _input(event):
	if event.is_action_pressed("action"):
		var window = pack.instantiate()
		var playerCords = get_viewport_transform() * (get_global_transform() * $player.position)
		add_child(window)
		window.position = playerCords

#
func _on_key_body_entered(body):
	if body.name == "player":
		isCollected = true
		#$key/keyColl.set_deferred("disabled", true)

var gateUnlocked = false
func _on_unlock_area_body_entered(area):
	print(area.name)
	if area.is_in_group("pickup"):
		print("key inserted")
		gateUnlocked = true
		area.z_index += 1
		print("gate unlocked")
		await get_tree().create_timer(0.5).timeout
		$lockedGate/lockedGateColl.set_deferred("disabled", true)
		$Camera2D.shake(10,15)
		area.get_node("keySprite").play("destroy")
		area.get_node("keyParticles").emitting = true
		$lockedGate/lockedGateColl/blocks/AnimationPlayer.play("keyinserted")
		await area.get_node("keySprite").finished("destroy")
		area.visible = false
	#if isCollected == true:
		#gateUnlocked = true
		#isCollected = false
		#$key/keySprite.play("RESET")
		#$key.z_index += 1
		#print("gate unlocked")
		#await get_tree().create_timer(0.5).timeout
		#$lockedGate/lockedGateColl.set_deferred("disabled", true)
		#$Camera2D.shake(10,15)
		#$key/keySprite.play("destroy")
		#$key/keyColl/keyParticles.emitting = true
		#$lockedGate/lockedGateColl/blocks/AnimationPlayer.play("keyinserted")
		#await $key/keySprite.finished("destroy")
		#$key.visible = false


func _on_flag_body_entered(body):
	if body.name == "player":
		get_tree().reload_current_scene()


func _on_unlock_area_area_entered(area):
	pass
