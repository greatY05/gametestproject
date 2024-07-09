extends Area2D

@export var camera = Node2D
var camX 

func _ready():
	camX = camera.position.x
	print(SceneManager.curLevel)



func change_scene(num):
	SceneManager.switch_scene(SceneManager.levels[num])

#bug - restarting a scene breaks the switchign scenes system
func _on_body_entered(body):
	if body.name == "player":
		$flagColl.set_deferred("disabled", true)
		$winParticles.emitting = true
		await get_tree().create_timer(0.5).timeout
		camera.on_level_done(camX)
		await get_tree().create_timer(0.5).timeout
		SceneManager.curLevel += 1 
		change_scene(SceneManager.curLevel)
