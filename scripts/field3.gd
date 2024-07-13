extends Node2D


func _ready():
	SceneManager.curLevel = 3
	var tween = get_tree().create_tween()
	tween.tween_property($Camera2D, "position", Vector2($Camera2D.position.x, 265), SceneManager.camSpeed).set_trans(Tween.TRANS_CUBIC)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spikezone_body_entered(body):
	if body.name == "player":
		print("you died")
		$Camera2D.shake(1, 5)
		await get_tree().create_timer(0.5).timeout
		body.position = $Marker2D.position
