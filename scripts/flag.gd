extends Area2D

#moved to scenemanager
#var levels : Array = ["res://scenes/field.tscn", "res://scenes/field2.tscn", "res://scenes/windowpopup.tscn"]

func _ready():
	print(SceneManager.curLevel)


func change_scene(num):
	SceneManager.switch_scene(SceneManager.levels[num])

#bug - restarting a scene breaks the switchign scenes system
func _on_body_entered(body):
	if body.name == "player":
		SceneManager.curLevel += 1 
		change_scene(SceneManager.curLevel)
