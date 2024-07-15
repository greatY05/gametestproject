extends Polygon2D


func _ready():
	var CollShape = CollisionPolygon2D.new()
	CollShape.polygon = polygon
	$StaticBody2D.add_child(CollShape)
