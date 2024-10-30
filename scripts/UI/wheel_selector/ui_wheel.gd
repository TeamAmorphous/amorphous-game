## TODO: Document code
@tool
extends Control

# TODO: Add item count on corner of sprite

signal create_label(name : String, content : String)
signal update_label(name : String, content : String)
signal delete_label(name : String)

@export var sprite_size := Vector2(96, 96)

@export var background_color : Color = Color.BLACK
@export var line_color : Color = Color.RED
@export var hightlight_color : Color = Color.GRAY
@export var selection_outline_color : Color = Color.RED
@export var show_item_count : bool = true

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
	# Draw Background Circle
	# Draw Highlight Arc
	# Draw Division Lines
	# Draw Sprites (including highlighted brigtness)
	# Draw item count
	# Draw Outer Circle Line
	# Draw Inner Circle Line
	# Draw Hightlight Line

	var offset = sprite_size / -2

	# Draw Background Circle
	draw_circle(Vector2.ZERO, outer_radius + background_offset, background_color)

	# Draw Highlight Arc
	var arc : PackedVector2Array = arc_calculation()
	draw_polygon(
		arc,
		PackedColorArray([hightlight_color])
		)

	# Draw Division Lines and Sprites
	for i in range(len(options)):
		var angle = TAU * i / ((len(options)))
		var line = Vector2.from_angle(angle)
		draw_line(
			line*(inner_radius+line_cutoff),
			line*(outer_radius-line_cutoff),
			line_color,
			line_width
			)

		#Draw Sprites for Items
		var start_rads = (TAU * (i-1) / (len(options)))
		var end_rads = (TAU * i) / (len(options))
		var mid_rads = (start_rads + end_rads) / 2.0 * -1
		var radius_mid = (inner_radius + outer_radius) / 2
		var draw_pos =  radius_mid * Vector2.from_angle(mid_rads) + offset
		# Modulate color of unselected sprites
		if selection != i:
			draw_texture_rect_region(
				options[i].atlas,
				Rect2(draw_pos, sprite_size),
				options[i].region,
				Color(1, 1, 1, 0.5)
				)
		else:
			draw_texture_rect_region(
				options[i].atlas,
				Rect2(draw_pos, sprite_size),
				options[i].region,
				)
		if show_item_count:
			var label_count : Label = Label.new()
			label_count.label_settings = LabelSettings.new()
			label_count.label_settings.font_color = Color.WHITE
			label_count.label_settings.font_size = 32
			label_count.position = draw_pos + Vector2(-80, 80)
			label_count.text = str(options[i].count)
			#add_child(label_count)

	# Draw Outer Circle Line
	draw_arc(Vector2.ZERO, outer_radius, 0, TAU, 128, line_color, line_width)

	# Draw Inner Circle Line
	draw_arc(Vector2.ZERO, inner_radius, 0, TAU, 128, line_color, line_width)

	# Draw Hightlight Line
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
		selection = ceil((mouse_rads / TAU) * (len(options)))

	print(selection)
	queue_redraw()

func arc_calculation() -> PackedVector2Array:
	var start_rads = (TAU * (selection-1) / (len(options)))
	var end_rads = (TAU * selection) / (len(options))
	var points_per_arc = 32

	var points_inner = PackedVector2Array()
	var points_outer = PackedVector2Array()

	for j in range(points_per_arc + 1):
		var angle = start_rads + j * (end_rads - start_rads) / points_per_arc
		points_inner.append(inner_radius * Vector2.from_angle(TAU - angle))
		points_outer.append(outer_radius * Vector2.from_angle(TAU - angle))

	points_outer.reverse()
	return points_inner + points_outer
