extends Camera2D

@export var strenght: float = 1
@export var fade: float = 0.001

var rng = RandomNumberGenerator.new()

var curStrenght: float = 0

func apply_force():
	curStrenght = strenght

func shake():
	apply_force()

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
