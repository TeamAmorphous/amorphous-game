## TODO: Document code
@tool
extends Control

# TODO: Add item count on corner of sprite

const SPRITE_SIZE = Vector2(32, 32)


@export var background_color : Color = Color.BLACK
@export var line_color : Color = Color.RED
@export var hightlight_color : Color = Color.GRAY
@export var selection_outline_color : Color = Color.RED

@export var outer_radius : int = 256
@export var inner_radius : int = 64
@export var line_width : int = 4
@export var panel_offset : int = 5
@export var line_cutoff : int = 15
@export var background_offset : int = 15
@export var highlighted_line_width : int = 7

@export var options : Array[WheelOption]

var selection = 0

func _draw() -> void:
	#TODO: Set code regions for function

	# Gen algo:
	# draw sprites (including highlighted brigtness)
	# draw item count

	var offset = SPRITE_SIZE / -2

	# Draw Background Circle
	draw_circle(Vector2.ZERO, outer_radius + background_offset, background_color)

	# Draw Highlight Arc
	var arc : PackedVector2Array = arc_calculation()
	draw_polygon(
		arc,
		PackedColorArray([hightlight_color])
		)

	# Draw Lines
	for i in range(len(options)):
		var rads = TAU * i / ((len(options) - 1))
		var point = Vector2.from_angle(rads)
		draw_line(
			point*(inner_radius+line_cutoff),
			point*(outer_radius-line_cutoff),
			line_color,
			line_width
			)

	# draw_texture_rect_region(
	# 	options[0].atlas,
	# 	Rect2(offset, SPRITE_SIZE),
	# 	options[0].region
	# 	)

	for i in range(1, len(options)):
		pass

	# Draw inner circle line
	draw_arc(Vector2.ZERO, inner_radius, 0, TAU, 128, line_color, line_width, true)

	# Draw outer circle line
	draw_arc(Vector2.ZERO, outer_radius, 0, TAU, 128, line_color, line_width, true)

	if len(options) >= 3:
		for i in range(len(options) - 1):
			var rads = TAU * i / ((len(options) - 1))
			var point = Vector2.from_angle(rads)
			draw_line(
				point*(inner_radius+line_cutoff),
				point*(outer_radius-line_cutoff),
				line_color,
				line_width
				)
		draw_texture_rect_region(
			options[0].atlas,
			Rect2(offset, SPRITE_SIZE),
			options[0].region
			)

	#Draw Hightlight Line
	draw_polyline(
		arc + arc.slice(0,1),
		selection_outline_color,
		highlighted_line_width
		)

func _process(_delta: float) -> void:
	var mouse_pos = get_local_mouse_position()
	var mouse_radius = mouse_pos.length()

	if mouse_radius < inner_radius:
		selection = 0
	else:
		var mouse_rads = fposmod(mouse_pos.angle() * -1, TAU)
		selection = ceil((mouse_rads / TAU) * (len(options) - 1))

	print(selection)
	queue_redraw()

func arc_calculation() -> PackedVector2Array:
	var start_rads = (TAU * (selection-1) / (len(options) - 1))
	var end_rads = (TAU * selection) / (len(options) - 1)
	var points_per_arc = 32

	var points_inner = PackedVector2Array()
	var points_outer = PackedVector2Array()

	for j in range(points_per_arc + 1):
		var angle = start_rads + j * (end_rads - start_rads) / points_per_arc
		points_inner.append(inner_radius * Vector2.from_angle(TAU - angle))
		points_outer.append(outer_radius * Vector2.from_angle(TAU - angle))

	points_outer.reverse()
	return points_inner + points_outer
