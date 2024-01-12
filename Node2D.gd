extends Node2D



var layers = []
var fingers = {}

var mouse_enable = false

func _ready():
	layer_add()

func _process(delta):
	print(delta)
	layers[-1].draw_req()

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
	
	# TODO: multi touch event fix
	if event is InputEventScreenTouch:
		if event.index not in fingers:
			fingers[event.index] = preload("res://layer.gd").new()
		if not event.pressed:
			layers.append(fingers[event.index])
			add_child(fingers[event.index])
			fingers[event.index] = preload("res://layer.gd").new()
	if event is InputEventScreenDrag:
		fingers[event.index].points.append(Vector2(event.position.x, event.position.y))
		fingers[event.index].draw_req()

func layer_add():
	var l = preload("res://layer.gd").new()
	l.color = Color(randf(), randf(), randf())
	layers.append(l)
	add_child(l)
