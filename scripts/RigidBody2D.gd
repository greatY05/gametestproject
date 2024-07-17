extends RigidBody2D

@export var pol = Polygon2D
# Called when the node enters the scene tree for the first time.
func _ready():
	var polygon_global_position = pol.global_position
	var pol_center = get_polygon_center()
	global_position += pol_center + pol.position
	pol.global_position = polygon_global_position
	
	var collision_shape = CollisionPolygon2D.new()
	collision_shape.polygon = offset_polygon_points(pol_center)
	add_child(collision_shape)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func offset_polygon_points(center):
	var adjPoints = []
	for point in pol.polygon:
		adjPoints.append(point-center)
	return adjPoints

func get_polygon_center():
	var weight = pol.polygon.size()
	var center = Vector2(0, 0)
	for point in pol.polygon:
		center.x += point.x /weight
		center.y += point.y /weight
	return center
