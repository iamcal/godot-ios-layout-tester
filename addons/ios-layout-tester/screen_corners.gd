extends Node2D

var radius = 62

func _ready() -> void:
	get_viewport().size_changed.connect(on_resize)


func on_resize():
	queue_redraw()

func _draw():
	var screen = DisplayServer.window_get_size()
	var r2 = radius + radius
	
	# fill everything
	draw_rect(Rect2(0, 0, screen.x, screen.y), Color.WHITE)
	
	# top left, top right
	draw_circle(Vector2(radius,radius), radius, Color.BLACK)
	draw_circle(Vector2(screen.x-radius,radius), radius, Color.BLACK)

	# bottom left, bottom, right
	draw_circle(Vector2(radius, screen.y-radius), radius, Color.BLACK)
	draw_circle(Vector2(screen.x-radius, screen.y-radius), radius, Color.BLACK)

	# top, bottom
	draw_rect(Rect2(radius, 0, screen.x-r2, radius), Color.BLACK)
	draw_rect(Rect2(radius, screen.y-radius, screen.x-r2, radius), Color.BLACK)
	
	# left, right
	draw_rect(Rect2(0, radius, radius, screen.y-r2), Color.BLACK)
	draw_rect(Rect2(screen.x-radius, radius, radius, screen.y-r2), Color.BLACK)

	# middle
	draw_rect(Rect2(radius, radius, screen.x-r2, screen.y-r2), Color.BLACK)
	
	#TODO: mnight need to use a shader to allow us to perform math
	# on a per-pixel basis
