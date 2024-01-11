extends Node2D

@export var points = []
@export var color = Color.WHITE
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	var i = 1
	while i < points.size()-1:
		draw_line(points[i-1],points[i],color, 3, true)
		i+=1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
