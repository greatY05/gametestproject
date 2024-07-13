extends Control

@onready var colorRect = $ColorRect


var tween = null

func _on_quit_button_up():
	print("bye bye")
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()

func _ready():
	tween = get_tree().create_tween()
	colorShift()

#stores the last color the tween was on to continue when the mouse leaves the button area
var colorStopped
#checks if you clicked start button to pause the tween animations
var started = false
var color = 0.4

func colorShift():
	tween.set_loops()
	tween.tween_property($ColorRect, "color", Color(color, color, 0.8, 1), 2).set_trans(Tween.TRANS_SINE)
	tween.tween_property($ColorRect, "color", Color(color, 0.8 , color, 1),2).set_trans(Tween.TRANS_SINE)
	tween.tween_property($ColorRect, "color", Color(0.8, color , color, 1),2).set_trans(Tween.TRANS_SINE)
	print(colorRect.color)



func _on_lvl_select_button_up():
	started = true
	var tweenCam = get_tree().create_tween()
	tweenCam.tween_property($Camera2D, "position", Vector2(575, 1024), 1).set_trans(Tween.TRANS_CUBIC)
	await tweenCam.finished
	SceneManager.switch_scene(SceneManager.levels[1])



func _on_lvl_select_mouse_entered():
	colorStopped = colorRect.color
	tween.pause()
	var tween2 = get_tree().create_tween()
	tween2.tween_property($ColorRect, "color", Color(0.874, 0.9647, 0.9607, 1), 0.3).set_trans(Tween.TRANS_LINEAR)



func _on_lvl_select_mouse_exited():
	if not started:
		var tween3 = get_tree().create_tween()
		tween3.tween_property($ColorRect, "color", colorStopped, 0.3).set_trans(Tween.TRANS_LINEAR)
		await tween3.finished
		tween.play()


func _on_lvl_select_button_down():
	tween.pause()
	


