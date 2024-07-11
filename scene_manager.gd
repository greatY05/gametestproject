extends Node

var curScene 
func _ready():
	var root = get_tree().root
	curScene = root.get_child(root.get_child_count() - 1)
	print(curScene)


var curLevel = 0
var levels : Array = ["res://scenes/field.tscn", "res://scenes/field2.tscn", "res://scenes/mainmenu.tscn"]
var camSpeed = 0.7


func switch_scene(Path):
	print(Path, " got")
	call_deferred("def_switch_scene", Path)

func def_switch_scene(Path):
	curScene.free()
	var s = load(Path)
	curScene = s.instantiate()
	get_tree().root.add_child(curScene)
	get_tree().current_scene = curScene
	print(curScene, " done")


func _input(event):
	if event.is_action("esc"):
		get_tree().quit()
	if Input.is_key_pressed(KEY_R):
		restart()
	if Input.is_key_pressed(KEY_X):
		var p = preload("res://scenes/mainmenu.tscn").instantiate()
		p.colorshift()

func restart():
	switch_scene(levels[curLevel])

