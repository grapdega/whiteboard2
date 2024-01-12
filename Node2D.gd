extends Node2D



var layers = []
var fingers = {}

var mouse_enable = false

func _ready():
	layer_add()

func _input(event):

	if event is InputEventMouseButton:
		mouse_enable = event.pressed
		if not mouse_enable:
			layer_add()
			layers[-1].points = []
		else:
			layers[-1].points.append(Vector2(get_global_mouse_position().x, get_local_mouse_position().y))
	if event is InputEventMouseMotion:
		if mouse_enable:
			layers[-1].points.append(Vector2(get_global_mouse_position().x, get_local_mouse_position().y))
	layers[-1].queue_redraw()

	# TODO: multi touch event fix
	return
	if event is InputEventScreenTouch:
		if event.index not in fingers:
			fingers[event.index] = []
		if not event.pressed:
			layer_add()
			layers[-1].points = fingers[event.index]
			fingers[event.index] = []
	if event is InputEventScreenDrag:
		fingers[event.index].append(Vector2(event.position.x, event.position.y))

func layer_add():
	var l = preload("res://layer.gd").new()
	l.color = Color(randf(), randf(), randf())
	layers.append(l)
	add_child(l)
