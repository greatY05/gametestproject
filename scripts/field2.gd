extends Node2D

@onready var blockCollArea = $block/blockCollArea



func _ready():
	SceneManager.curLevel = 1
	var tween = get_tree().create_tween()
	tween.tween_property($Camera2D, "position", Vector2(137, 0), SceneManager.camSpeed).set_trans(Tween.TRANS_CUBIC)


const speed = 5
func _process(delta):
	#if isCollected == true:
		#key.global_position = key.global_position.lerp($player/followPoint.global_position, speed*delta) 
	if gateUnlocked == true:
		keyToUse.global_position = keyToUse.global_position.lerp(blockCollArea.global_position, speed*delta) 


var gateUnlocked = false
#takes the first item (key) from the array which the player script stores the keys in
var keyToUse : Node2D

func _on_block_coll_area_body_entered(body):
	print(body.name)
	if body.name == "player" and gateUnlocked == false:
		if body.collectedItems.size() > 0:
		#the first key to enter the player and enter his carrying array, pops it out and uses it
			keyToUse = body.collectedItems.pop_front()
			print("key inserted")
			gateUnlocked = true
			keyToUse.z_index += 1
			print("gate unlocked")
			await get_tree().create_timer(0.5).timeout
			$block/blockCollArea/areaColl.set_deferred("disabled", true)
			$block/blockColl.set_deferred("disabled", true) 
			$block/blockSprite.hide()
			$Camera2D.shake(10,15)
			keyToUse.get_node("keySprite").play("destroy")
			keyToUse.get_node("keyParticles").emitting = true
			if keyToUse.keyDest == true:
				keyToUse.visible = false
