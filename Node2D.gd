extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var points = []
var lines = []
var fingers = {}

var mouse_enable = false
func _input(event):
	if event is InputEventMouseButton:
		mouse_enable = event.pressed
		if not mouse_enable:
			lines.append(points)
			points = []
	if event is InputEventScreenTouch:
		if event.index not in fingers:
			fingers[event.index] = []
		if not event.pressed:
			lines.append(fingers[event.index])
			fingers[event.index] = []
	if event is InputEventScreenDrag:
		fingers[event.index].append(Vector2(event.position.x, event.position.y))
	if event is InputEventMouseMotion:
		if mouse_enable:
			points.append(Vector2(get_global_mouse_position().x, get_local_mouse_position().y))
	
func _process(delta):
	queue_redraw()

func _draw():
	var fpnts = []
	for key in fingers.keys():
		fpnts.append(fingers[key])
	for pnts in lines  + [points] + fpnts:
		var i=1
		while i < pnts.size()-1:
			draw_line(pnts[i-1],pnts[i],Color.BLUE, 3, true)
			i+=1
