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


var colorStopped

var color = 0.4

func colorShift():
	tween.set_loops()
	tween.tween_property($ColorRect, "color", Color(color, color, 0.8, 1), 2).set_trans(Tween.TRANS_SINE)
	tween.tween_property($ColorRect, "color", Color(color, 0.8 , color, 1),2).set_trans(Tween.TRANS_SINE)
	tween.tween_property($ColorRect, "color", Color(0.8, color , color, 1),2).set_trans(Tween.TRANS_SINE)
	print(colorRect.color)
	
var started = false

func _on_lvl_select_button_up():
	started = true
	colorRect.color = Color(0.874, 0.9647, 0.9607, 1)
	var tweenCam = get_tree().create_tween()
	tweenCam.tween_property($ColorRect, "color", Color(0.874, 0.9647, 0.9607, 1), 0.3).set_trans(Tween.TRANS_LINEAR)
	tweenCam.tween_property($Camera2D, "position", Vector2(575, 1024), 1).set_trans(Tween.TRANS_CUBIC)
	await tweenCam.finished
	SceneManager.switch_scene(SceneManager.levels[0])



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
	


