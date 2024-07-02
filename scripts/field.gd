extends Node2D


@onready var box = $box
@onready var doorCollision = $gateArea
@onready var key = $key
@onready var switch = $switch
var switchId = 0


var isCollected = false

var newSwitch = preload("res://scenes/switch.tscn")
var newSwitchScript = preload("res://scripts/switch.gd")
func _ready():
	for i in 3:
		var switchNew = newSwitch.instantiate()
		print(switchNew)
		#switchNew.id = i
		#print(switchNew.id)

func restart():
	get_tree().reload_current_scene()

const speed = 5
func _process(delta):
	if isCollected == true:
		key.global_position = key.global_position.lerp($player/followPoint.global_position, speed*delta) 
	if isCollected == false and gateUnlocked == true:
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
		#var ci: CanvasItem = window
		#var root: Window = ci.get_tree().root
		
		#var ci_screen_pos: Vector2 = (root.get_final_transform() * ci.get_global_transform_with_canvas()).origin + Vector2(root.position)

		#var ci_global_pos: Vector2 = ci.get_global_transform().origin
		#var ci_screen_pos: Vector2 = (root.get_final_transform() * ci.get_canvas_transform()) * ci_global_pos + Vector2(root.position)
		##
		#both get cords of things right to the screen transform, doesnt work though so just acts as regular .position, if confusing just return to it
		var playerCords = get_viewport_transform() * (get_global_transform() * $player.position)
		#var windowCords = get_viewport_transform() * (get_global_transform() * Vector2(window.position.x, window.position.y))
		add_child(window)
		window.position = playerCords
	#	print( playerCords, windowCords, $player.get_screen_transform())

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
		$Camera2D.shake(10,15)
		$key/keySprite.play("destroy")
		$key/keyColl/keyParticles.emitting = true
		$lockedGate/lockedGateColl/blocks/AnimationPlayer.play("keyinserted")
		#await $key/keySprite.finished("destroy")
		#$key.visible = false


func _on_flag_body_entered(body):
	if body.name == "player":
		get_tree().reload_current_scene()
