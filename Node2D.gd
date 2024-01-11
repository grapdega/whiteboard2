extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var points = []
var lines = []

var mouse_enable = false
func _input(event):
	if event is InputEventMouseButton:
		mouse_enable = event.pressed
		if not mouse_enable:
			lines.append(points)
			points = []
	if event is InputEventMouseMotion:
		if mouse_enable:
			points.append(Vector2(get_global_mouse_position().x, get_local_mouse_position().y))
	
func _process(delta):
	queue_redraw()

func _draw():
	for pnts in lines  + [points]:
		var i=1
		while i < pnts.size()-1:
			draw_line(pnts[i-1],pnts[i],Color.BLUE, 3, true)
			i+=1
