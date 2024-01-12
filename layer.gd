extends Node2D

@export var points = []
@export var color = Color.WHITE
@export var width = 3

func _draw():
	var i = 1
	if points.size() > 0:
		draw_circle(points[0],width,color)

	while i < points.size():
		draw_line(points[i-1],points[i],color, width, true)
		i+=1

	if points.size() > 1:
		draw_line(points[-2],points[-1],color,width, true)
		draw_circle(points[-1],width,color)

var last_size = 0
func draw_req():
	if points.size() != last_size:
		queue_redraw()
		last_size = points.size()
