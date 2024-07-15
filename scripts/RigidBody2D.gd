extends RigidBody2D

@onready var pol = $Polygon2D
# Called when the node enters the scene tree for the first time.
func _ready():
	var polygon_global_position = pol.global_position
	#var polygon_center = get_polygon_center()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
