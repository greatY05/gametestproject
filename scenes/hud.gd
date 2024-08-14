extends CanvasLayer

var disabled = false
# Called when the node enters the scene tree for the first time.


func _ready():
	$"pause screen".hide()

func _input(event):
	if event.is_action_pressed("jump") and disabled == false:
		pause()


func pause():
	get_tree().paused = !get_tree().paused
	print("hi")
	$"pause screen".visible = !$"pause screen".visible



func _on_continue_button_button_up():
	pause()


func _on_main_menu_button_button_up():
	hide()
	get_tree().paused = !get_tree().paused
	SceneManager.exitToMenu()

func toggle():
	visible = !visible
	print("toggled")
	disabled = !disabled

