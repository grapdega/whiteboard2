extends Node2D

@export var points = []
@export var color = Color.WHITE
@export var width = 3

func _draw():
	var i = 2
	if points.size() > 0:
		draw_circle(points[0],width,color)
	while i < points.size():
		var p0 = points[i-2]
		var p1 = points[i-1]
		var smoot = cacl_distance(points[i-2],points[i])
		if smoot > 10:
			smoot = 10
			for t in range(smoot):
				p1 = _quadratic_bezier(points[i-2],points[i-1], points[i],t/smoot)
				draw_line(p0,p1,color, width, true)
				p0 = p1
			draw_line(p1, points[i],color, width, true)
		else:
			draw_line(points[i-2],points[i-1],color, width, true)
			draw_line(points[i-1],points[i],color, width, true)
		i+=2

	if points.size() > 1:
		draw_line(points[-2],points[-1],color,width, true)
		draw_circle(points[-1],width,color)

func cacl_distance(p0:Vector2, p1:Vector2):
	return int(sqrt(abs(p1.x-p0.x)**2 + abs(p0.y-p1.y)**2))

func _quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float):
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var r = q0.lerp(q1, t)
	return r
