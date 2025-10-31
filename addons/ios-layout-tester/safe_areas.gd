extends Node2D

var top = 0
var bottom = 0
var left = 0
var right = 0

func _draw():
	var screen = get_viewport_rect().size

	var color = Color(0.97, 0.51, 0.47, 0.5)

	if top:
		draw_rect(Rect2(0, 0, screen.x, top), color)

	if bottom:
		draw_rect(Rect2(0, screen.y-bottom, screen.x, bottom), color)

	if left:
		draw_rect(Rect2(0, top, left, screen.y-(top + bottom)), color)

	if right:
		draw_rect(Rect2(screen.x - right, top, right, screen.y-(top + bottom)), color)
