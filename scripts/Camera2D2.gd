extends Camera2D

@export var strenght: float = 5
@export var fade: float = 15

var rng = RandomNumberGenerator.new()

var curStrenght: float = 0

func apply_force(stri, fad):
	curStrenght = stri
	fade = fad

#send a wanted strenght of shake and fade for it through calling the function shake
func shake(stri, fad):
	apply_force(stri, fad)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if curStrenght > 0.5:
		curStrenght = lerpf(curStrenght,0 ,fade*delta)
		offset = randoffset()
	if curStrenght <= 0.5:
		offset = offset.lerp(Vector2(0,0), fade*delta*5)
#changes location of X and Y to create a shake
func randoffset():
	return Vector2(rng.randf_range(-strenght, strenght), rng.randf_range(-strenght, strenght))


func on_level_done(x):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(x, -428), 1).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
