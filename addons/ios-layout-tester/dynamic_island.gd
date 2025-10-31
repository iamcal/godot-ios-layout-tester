extends Node2D

var top_border: int = 11
var side_border: int = 134
var island_height: int = 37

var orientation: IosLayout.ScreenOrientation = IosLayout.ScreenOrientation.PORTRAIT

var color: Color = Color(0, 0, 0, 1)

func _ready() -> void:
	get_viewport().size_changed.connect(on_resize)

func on_resize():
	queue_redraw()

func _draw():
	var screen = get_viewport_rect().size

	var circ_radius = float(island_height) / 2

	if orientation == IosLayout.ScreenOrientation.PORTRAIT:

		draw_rect(Rect2(side_border + circ_radius, top_border, screen.x - (side_border + side_border + circ_radius + circ_radius), island_height), color)
	
		draw_circle(Vector2(side_border + circ_radius, top_border + circ_radius), circ_radius, color)
		draw_circle(Vector2(screen.x - (side_border + circ_radius), top_border + circ_radius), circ_radius, color)

	else:

		var x = top_border
		if orientation == IosLayout.ScreenOrientation.LANDSCAPE_R:
			x = screen.x - (island_height + top_border)

		draw_rect(Rect2(x, side_border + circ_radius, island_height, screen.y - (side_border + side_border + circ_radius + circ_radius)), color)

		draw_circle(Vector2(x + circ_radius, side_border + circ_radius), circ_radius, color)
		draw_circle(Vector2(x + circ_radius, screen.y - (side_border + circ_radius)), circ_radius, color)
