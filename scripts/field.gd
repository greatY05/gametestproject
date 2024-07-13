extends Node2D


@onready var box = $box
@onready var doorCollision = $gateArea
@onready var switch = $switch
var switchId = 0


var isCollected = false

var newSwitch = preload("res://scenes/switch.tscn")
var newSwitchScript = preload("res://scripts/switch.gd")


func _ready():
	SceneManager.curLevel = 1
	var tween = get_tree().create_tween()
	tween.tween_property($Camera2D, "position", Vector2($Camera2D.position.x, -28), SceneManager.camSpeed).set_trans(Tween.TRANS_CUBIC)

@onready var unlock_area = $lockedGate/unlockArea

const speed = 5
func _process(delta):
	#if isCollected == true:
		#key.global_position = key.global_position.lerp($player/followPoint.global_position, speed*delta) 
	if gateUnlocked == true:
		keyToUse.global_position = keyToUse.global_position.lerp(unlock_area.global_position, speed*delta) 






var pack = preload("res://scenes/window.tscn")

func _input(event):
	if event.is_action_pressed("action"):
		var window = pack.instantiate()
		var playerCords = get_viewport_transform() * (get_global_transform() * $player.position)
		add_child(window)
		window.position = playerCords
	if event.is_action("esc"):
		get_tree().quit()


var gateUnlocked = false
#takes the first item (key) from the array which the player script stores the keys in
var keyToUse : Node2D

func _on_unlock_area_body_entered(area):
	print(area.name)
	if area.name == "player" and gateUnlocked == false:
		if $lockedGate/unlockArea.get_overlapping_areas().size() > 0 and area.collectedItems.size() == 0:
			$lockedGate/hintTimer.start()
		if area.collectedItems.size() > 0:
		#the first key to enter the player and enter his carrying array, pops it out and uses it
			keyToUse = area.collectedItems.pop_front()
			print("key inserted")
			gateUnlocked = true
			keyToUse.z_index += 1
			print("gate unlocked")
			await get_tree().create_timer(0.5).timeout
			$lockedGate/lockedGateColl.set_deferred("disabled", true)
			$Camera2D.shake(10,15)
			keyToUse.get_node("keySprite").play("destroy")
			keyToUse.get_node("keyParticles").emitting = true
			$lockedGate/lockedGateColl/blocks/AnimationPlayer.play("keyinserted")
			if keyToUse.keyDest == true:
				keyToUse.visible = false
	
	
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

##local change for scene, dont use, use thrtough flagt scene
#func _on_flag_body_entered(body):
	#if body.name == "player":
		#get_tree().reload_current_scene()
		#SceneManager.switch_scene("res://scenes/field2.tscn")


var transP = 0
func _on_hint_timer_timeout():
	for i in 5:
		$helpText.add_theme_color_override("default_color", Color(1, 1, 1, transP))
		print($helpText.get_theme_color("default_color"))
		transP += 0.3
		await get_tree().create_timer(0.1).timeout
	await get_tree().create_timer(1).timeout
	for i in 6:
		$helpText.add_theme_color_override("default_color", Color(1, 1, 1, transP))
		print($helpText.get_theme_color("default_color"))
		transP -= 0.3
		await get_tree().create_timer(0.1).timeout
	print("i might need to get a key to open this...")
