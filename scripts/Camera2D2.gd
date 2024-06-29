extends Camera2D

@export var strenght: float = 5
@export var fade: float = 15

var rng = RandomNumberGenerator.new()

var curStrenght: float = 0

func apply_force(str, fd):
	curStrenght = str
	fade = fd

#send a wanted strenght of shake and fade for it through calling the function shake
func shake(str, fd):
	apply_force(str, fd)

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
