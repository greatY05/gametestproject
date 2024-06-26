extends Camera2D

@export var strenght: float = 30.0
@export var fade: float = 5.0

var rng = RandomNumberGenerator.new()

var curStrenght: float = 0.0

func apply_force():
	curStrenght = strenght

func shake():
	if Input.is_action_just_pressed("jump"):
		apply_force()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if curStrenght > 0.5:
		print(curStrenght)
		curStrenght = lerpf(curStrenght,0 ,fade*delta)
		offset = randoffset()
	if curStrenght <= 0.5:
		offset = offset.lerp(Vector2(0,0), fade*delta*5)
#changes location of X and Y to create a shake
func randoffset() -> Vector2:
	return Vector2(rng.randf_range(-strenght, curStrenght), rng.randf_range(-strenght, curStrenght))
