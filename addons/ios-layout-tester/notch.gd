extends Node2D

var notch_w: int = 100
var notch_h: int = 10

var orientation: IosLayout.ScreenOrientation = IosLayout.ScreenOrientation.PORTRAIT

var color: Color = Color(1, 1, 0, 1)

func _ready() -> void:
	get_viewport().size_changed.connect(on_resize)

func on_resize():
	queue_redraw()

func _draw():
	var screen = get_viewport_rect().size

	if orientation == IosLayout.ScreenOrientation.PORTRAIT:
		var padding = (screen.x - notch_w) / 2
		draw_rect(Rect2(padding, 0, screen.x - (padding + padding), notch_h), color)
		#draw_circle(Vector2(padding+5, 5), 4, Color(0,0,0,0))
	else:
		var x = 0
		var padding = (screen.y - notch_w) / 2
		if orientation == IosLayout.ScreenOrientation.LANDSCAPE_R:
			x = screen.x - notch_h
		
		draw_rect(Rect2(x, padding, notch_h, screen.y - (padding + padding)), color)
