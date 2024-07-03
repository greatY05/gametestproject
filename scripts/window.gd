extends Window

var presscount = 1
var combo = 0
var shake := 40
var halfshake := (shake/2) 
@onready var click = $Camera2D/click

func _process(_delta):
	if click.is_hovered():
		click.flat = false



var timeleft = 0
func _on_click_pressed():
	if combo <= 3:
		timeleft = $comboTimer.get_time_left()
		print(timeleft)
		print(shake, halfshake)
		#$comboTimer.
		for i in shake:
			position.x = position.x +1
		for i in shake:
			position.x = position.x -2
		for i in shake:
			position.x = position.x +1
		await get_tree().create_timer(0.1).timeout
		for i in halfshake:
			position.x = position.x +1
		for i in halfshake:
			position.x = position.x -2
		for i in halfshake:
			position.x = position.x +1
		print(shake, halfshake)
		shake += 20
		halfshake += 10
		combo += 1
		$comboTimer.start()
	elif combo > 3:
		#$Camera2D/click.button_mask
		click.disabled = true
		$Camera2D/fish.show()
		await get_tree().create_timer(1.5).timeout
		queue_free()






func _on_combo_timer_timeout():
	print("combo broke")
	combo = 0
	shake = 40 
	halfshake = (shake/2) 
