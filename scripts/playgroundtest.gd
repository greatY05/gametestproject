extends Node2D

@onready var p = $Polygon2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	p.texture_offset += Vector2(0.1,0.1)
	p.texture_repeat = true
	p.texture.noise.fractal_ping_pong_strength += 0.01
#
	#for i in 1000:
		#p.texture_offset += Vector2(-0.1,-0.1)
		#p.texture_repeat = true
		#p.texture.noise.fractal_ping_pong_strength -= 0.01
