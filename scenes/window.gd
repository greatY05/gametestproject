extends Window

var presscount = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var combo = 0
var shake = 40 
var halfshake = (shake/2) 

var timeleft = 0
func _on_button_pressed():
	timeleft = $comboTimer.get_time_left()
	print(timeleft)
	print(shake, halfshake)
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
	if combo <= 3:
		shake += 20
		halfshake += 10
		combo += 1
		$comboTimer.start()






func _on_combo_timer_timeout():
	print("combo broke")
	combo = 0
	shake = 40 
	halfshake = (shake/2) 
