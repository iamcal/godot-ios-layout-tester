extends CanvasLayer
class_name IosLayout

enum ScreenOrientation {
	PORTRAIT	= 0,
	LANDSCAPE_L	= 1,
	LANDSCAPE_R	= 2,
}

@onready var dynamic_island = $DynamicIsland
@onready var notch = $Notch
@onready var safe_areas = $SafeAreas

var big_island = false
var orientation = ScreenOrientation.PORTRAIT

# 
# https://www.ios-resolution.com/
#
# https://useyourloaf.com/blog/iphone-17-screen-sizes/
# https://useyourloaf.com/blog/iphone-15-screen-sizes/
# https://useyourloaf.com/blog/iphone-16-screen-sizes/
# https://useyourloaf.com/blog/iphone-14-screen-sizes/
# https://useyourloaf.com/blog/iphone-13-screen-sizes/
# https://useyourloaf.com/blog/ipad-2024-screen-sizes/
# 
# https://www.behance.net/gallery/153642485/Dynamic-Island-Reference-Dimensions?locale=en_US
# https://phonesized.com/notch/
#
# safe zone order is:
#	portrait top
#	portrait bottom
#	landscape top
#	landscape bottom
#

const IDX_NAME = 0
const IDX_WIDTH = 1
const IDX_HEIGHT = 2
const IDX_SCALE = 3
const IDX_DYNAMIC_ISLAND = 4
const IDX_NOTCH = 5
const IDX_SAFE_PORTRAIT_TOP = 6
const IDX_SAFE_PORTRAIT_BTM = 7
const IDX_SAFE_LANDSCAPE_TOP = 8
const IDX_SAFE_LANDSCAPE_BTM = 9
const IDX_NOTCH_W = 10
const IDX_NOTCH_H = 11

const PRESETS = [
	# label 				width,	height,	scaling,	dynamic_island	notch		safe zones			notch size

	['iPhone 17 Pro Max',	440,	956,	3,			true,			false,		62, 34, 20, 20,		0, 0],
	['iPhone 17 Pro',		402,	874,	3,			true,			false,		62, 34, 20, 20,		0, 0],
	['iPhone 17',			402,	874,	3,			true,			false,		62, 34, 20, 20,		0, 0],

	['iPhone Air',			420,	912,	3,			true,			false,		68, 34, 20, 29,		0, 0],

	['iPhone 16 Pro Max', 	440,	956,	3,			true,			false,		62, 34, 0, 21,		0, 0],
	['iPhone 16 Pro',		402,	874,	3,			true,			false,		62, 34, 0, 21,		0, 0],
	['iPhone 16 Plus',		430,	932,	3,			true,			false,		59, 34, 0, 21,		0, 0],
	['iPhone 16',			393,	852,	3,			true,			false,		59, 34, 0, 21,		0, 0],

	['iPhone 15 Pro Max',	430,	932,	3,			true,			false,		59, 34, 0, 21,		0, 0],
	['iPhone 15 Pro',		393,	852,	3,			true,			false,		59, 34, 0, 21,		0, 0],
	['iPhone 15 Plus',		430,	932,	3,			true,			false,		59, 34, 0, 21,		0, 0],
	['iPhone 15',			393,	852,	3,			true,			false,		59, 34, 0, 21,		0, 0],

	['iPhone 14 Pro Max',	430,	932,	3,			true,			false,		59, 34, 0, 21,		0, 0],
	['iPhone 14 Pro',		393,	852,	3,			true,			false,		59, 34, 0, 21,		0, 0],
	['iPhone 14 Plus',		428,	926,	3,			false,			true,		47, 34, 0, 21,		500, 104], # notch size is a guess
	['iPhone 14',			390,	844,	3,			false,			true,		47, 34, 0, 21,		500, 104], # notch size is a guess

	['iPhone SE (3rd)',		375,	667,	2,			false,			true,		47, 34, 0, 21,		332, 69],  # safe zones and notch sizes are a guess

	['iPhone 13 Pro Max',	428,	926,	3,			false,			true,		47, 34, 0, 21,		496, 103],
	['iPhone 13 Pro',		390,	844,	3,			false,			true,		47, 34, 0, 21,		500, 104],
	['iPhone 13 Mini',		375,	812,	3,			false,			true,		50, 34, 0, 21,		500, 104], # notch size is a guess
	['iPhone 13',			390,	844,	3,			false,			true,		47, 34, 0, 21,		506, 108],

	['iPad Mini (7th)',		744,	1133,	2,			false,			false,		24, 20, 0, 0,		0, 0],
	['iPad Pro 13" (7th)',	1032,	1376,	2,			false,			false,		24, 20, 0, 0,		0, 0],
	['iPad Pro 11" (7th)',	834,	1210,	2,			false,			false,		24, 20, 0, 0,		0, 0],
	['iPad Air 13" (6th)',	1024,	1366,	2,			false,			false,		24, 20, 0, 0,		0, 0],
	
	['iPad Air 11" (6th)',	820,	1180,	2,			false,			false,		24, 20, 0, 0,		0, 0],
	['iPad Pro 13" (6th)',	1024,	1366,	2,			false,			false,		24, 20, 0, 0,		0, 0],
	['iPad Pro 11" (6th)',	834,	1194,	2,			false,			false,		24, 20, 0, 0,		0, 0],
	['iPad (10th)',			820,	1180,	2,			false,			false,		24, 20, 0, 0,		0, 0],
	['iPad Air (5th)',		820,	1180,	2,			false,			false,		24, 20, 0, 0,		0, 0],
	['iPad Mini (6th)',		744,	1133,	2,			false,			false,		24, 20, 0, 0,		0, 0],
	['iPad (9th)',			810,	1080,	2,			false,			false,		24, 20, 0, 0,		0, 0],
	['iPad Pro 13" (5th)',	1024,	1366,	2,			false,			false,		24, 20, 0, 0,		0, 0],
	['iPad Pro 11" (5th)',	834,	1194,	2,			false,			false,		24, 20, 0, 0,		0, 0],
]

# when in portrait:
#	top and bottom are variable
# when in landscape:
#	left and right are both same as portrait-top
#	top and bottom are variable

var content_scale = 1

func _ready() -> void:
	get_viewport().size_changed.connect(on_resize)

	%OptionButton.clear()
	for i in PRESETS.size():
		%OptionButton.add_item(PRESETS[i][IDX_NAME], i)

	update_all()

func on_resize():
	pass

func get_config() -> Array:
	return PRESETS[%OptionButton.get_selected_id()]

func _on_button_pressed() -> void:
	big_island = not big_island
	update_island()

func _on_orientation_button_pressed() -> void:
	# shuffle
	if orientation == ScreenOrientation.PORTRAIT:
		orientation = ScreenOrientation.LANDSCAPE_L
	elif orientation == ScreenOrientation.LANDSCAPE_L:
		orientation = ScreenOrientation.LANDSCAPE_R
	else:
		orientation = ScreenOrientation.PORTRAIT
	
	update_all()

func update_all() -> void:
	update_dimensions()
	update_island()
	update_notch()
	update_safe_areas()

func update_island() -> void:
	var config = get_config()
	
	dynamic_island.orientation = orientation

	if config[IDX_DYNAMIC_ISLAND]:
		dynamic_island.show()
	else:
		dynamic_island.hide()
	
	if orientation == ScreenOrientation.PORTRAIT and big_island:

		dynamic_island.top_border = 11 * config[IDX_SCALE]
		dynamic_island.side_border = 10 * config[IDX_SCALE]
		dynamic_island.island_height = 83 * config[IDX_SCALE]

	else:
		#side_bdr = floor((screen.x - 125) / 2)
		dynamic_island.top_border = 11 * config[IDX_SCALE]
		dynamic_island.side_border = 134 * config[IDX_SCALE]
		dynamic_island.island_height = 37 * config[IDX_SCALE]

	dynamic_island.queue_redraw()

func update_notch() -> void:
	var config = get_config()
	
	notch.orientation = orientation

	if config[IDX_NOTCH]:
		notch.show()
	else:
		notch.hide()

	notch.notch_w = config[IDX_NOTCH_W]
	notch.notch_h = config[IDX_NOTCH_H]

	notch.queue_redraw()

func update_safe_areas() -> void:
	var config = get_config()

	if config[IDX_DYNAMIC_ISLAND] or config[IDX_NOTCH]:
		if orientation == ScreenOrientation.PORTRAIT:
			safe_areas.top = config[IDX_SAFE_PORTRAIT_TOP] * config[IDX_SCALE]
			safe_areas.bottom = config[IDX_SAFE_PORTRAIT_BTM] * config[IDX_SCALE]
			safe_areas.left = 0
			safe_areas.right = 0
		else:
			safe_areas.left = config[IDX_SAFE_PORTRAIT_TOP] * config[IDX_SCALE]
			safe_areas.right = config[IDX_SAFE_PORTRAIT_TOP] * config[IDX_SCALE]
			safe_areas.top = config[IDX_SAFE_LANDSCAPE_TOP] * config[IDX_SCALE]
			safe_areas.bottom = config[IDX_SAFE_LANDSCAPE_BTM] * config[IDX_SCALE]
	else:
		safe_areas.top = config[IDX_SAFE_PORTRAIT_TOP] * config[IDX_SCALE]
		safe_areas.bottom = config[IDX_SAFE_PORTRAIT_BTM] * config[IDX_SCALE]
		safe_areas.left = 0
		safe_areas.right = 0

	safe_areas.queue_redraw()

func update_dimensions() -> void:
	var config = get_config()
	var window = get_window()

	if orientation == ScreenOrientation.PORTRAIT:
		window.size = Vector2(config[IDX_WIDTH], config[IDX_HEIGHT])
	else:
		window.size = Vector2(config[IDX_HEIGHT], config[IDX_WIDTH])
		
	window.content_scale_factor = 1.0 / config[IDX_SCALE]
	
	$Toolbar.theme.default_font_size = 16.0 * config[IDX_SCALE]
	$Toolbar.theme.set('HBoxContainer/constants/separation', 10.0 * config[IDX_SCALE])
	$Toolbar.theme.get('PanelContainer/styles/panel').set('border_width_left', 10.0 * config[IDX_SCALE])
	$Toolbar.theme.get('PanelContainer/styles/panel').set('border_width_right', 10.0 * config[IDX_SCALE])
	$Toolbar.theme.get('PanelContainer/styles/panel').set('border_width_top', 10.0 * config[IDX_SCALE])
	$Toolbar.theme.get('PanelContainer/styles/panel').set('border_width_bottom', 10.0 * config[IDX_SCALE])
	$Toolbar.theme.get('PanelContainer/styles/panel').set('content_margin_left', 20.0 * config[IDX_SCALE])
	$Toolbar.theme.get('PanelContainer/styles/panel').set('content_margin_right', 20.0 * config[IDX_SCALE])
	$Toolbar.theme.get('PanelContainer/styles/panel').set('content_margin_top', 20.0 * config[IDX_SCALE])
	$Toolbar.theme.get('PanelContainer/styles/panel').set('content_margin_bottom', 20.0 * config[IDX_SCALE])
	

func _on_option_button_item_selected(_index: int) -> void:
	update_all()
