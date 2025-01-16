@tool
extends Control

## The Custom Wheel Menu Script
##
## This class is the implementation of a custom wheel menu control, this custom
## UI will serve the purpose of quick selection of items during combat or in
## quick menus.
##
## @tutorial:												https://www.youtube.com/watch?v=TtziEJZtWXc

@export var sprite_size := Vector2(96, 96)
@export var background_color := Color.BLACK
@export var line_color := Color.RED
@export var hightlight_color := Color.GRAY
@export var selection_outline_color := Color.RED
@export var outer_radius := 256
@export var inner_radius := 64
@export var line_width := 4
@export var line_cutoff := 15
@export var background_offset := 15
@export var highlighted_line_width := 7
@export var wheel_options : Array[WheelOption]
var selection := -1
var angle_offset := -(PI/2)
var arc_angle := (TAU / len(wheel_options))

## On ready the control object will create the labels for the objects in the
## wheel and add them to the tree.
func _ready() -> void:
	#TODO: Move the label population to _process() so labels update in real time.
	var offset = sprite_size / -2
	for i in len(wheel_options):
		var mid_rads = ((TAU/len(wheel_options)) * i) + angle_offset
		var radius_mid = (inner_radius + outer_radius) / 2
		var draw_pos = radius_mid * Vector2.from_angle(mid_rads) + offset
		create_label(wheel_options[i].name, draw_pos, wheel_options[i].count)


## The draw call will draw the wheel menu and update the number of sprites in
## real time. Make sure all draw calls are put in this function.
func _draw() -> void:
	# Offset position for centering sprites
	var sprite_offset := sprite_size / -2
	var highlight_arc : PackedVector2Array

	# Draw Background Circle
	draw_circle(Vector2.ZERO, outer_radius + background_offset, background_color)
	# Draw Outer Circle Line
	draw_arc(Vector2.ZERO, outer_radius, 0, TAU, 128, line_color, line_width)
	# Draw Inner Circle Line
	draw_arc(Vector2.ZERO, inner_radius, 0, TAU, 128, line_color, line_width)

	# Draw Highlight Arc if a selection is made
	if selection != -1:
		highlight_arc = arc_calculation()
		draw_polygon(
			highlight_arc,
			PackedColorArray([hightlight_color])
		)

	# Draw sprites & lines
	for i in range(len(wheel_options)):
		var mid_rads = ((TAU/len(wheel_options)) * i) + angle_offset
		var radius_mid = (inner_radius + outer_radius) / 2
		var draw_pos = radius_mid * Vector2.from_angle(mid_rads) + sprite_offset
		# Draw unselected sprites darker
		if i != selection:
			draw_texture_rect_region(
				wheel_options[i].atlas,
				Rect2(draw_pos, sprite_size),
				wheel_options[i].region,
				Color(1, 1, 1, 0.5)
			)
		else:
			draw_texture_rect_region(
				wheel_options[i].atlas,
				Rect2(draw_pos, sprite_size),
				wheel_options[i].region
			)
		# Calculate the angle for each line starting from the top
		var line_vector = Vector2.from_angle(mid_rads - (arc_angle/2))
		# Draw division line from inner to outer radius
		draw_line(
			line_vector * (inner_radius + line_cutoff),
			line_vector * (outer_radius - line_cutoff),
			line_color,
			line_width
		)

	# Draw Highlight Line and Center Sprite if selected
	if selection != -1:
		draw_circle(Vector2.ZERO, inner_radius + 5, selection_outline_color)
		draw_texture_rect_region(
			wheel_options[selection].atlas,
			Rect2(Vector2.ZERO + sprite_offset + Vector2(0, -25), sprite_size),
			wheel_options[selection].region
		)
		draw_polyline(
			highlight_arc + highlight_arc.slice(0,1),
			selection_outline_color,
			highlighted_line_width
		)


## Each frame recalculate the selection according to the mouse position, update
## the item labels, and make a new draw call
func _process(_delta: float) -> void:
	arc_angle = (TAU / len(wheel_options))
	var mouse_pos = get_local_mouse_position()
	var mouse_radius = mouse_pos.length()
	if mouse_radius > outer_radius:
		selection = -1
	else:
		var mouse_rads = fposmod((mouse_pos.angle_to(Vector2(0,-1)) - (arc_angle / 2)) * -1, TAU)
		selection = floor((mouse_rads / TAU) * (len(wheel_options)))

	line_color = wheel_options[selection].color
	hightlight_color = line_color - Color(0, 0, 0, .5)
	selection_outline_color = line_color + Color(0.2, 0.2, 0.2, 1)
	get_node("Selection").set("theme_override_colors/font_color", line_color - Color(0.4, 0.4, 0.4, 0))

	for i in range(len(wheel_options)):
		get_node(wheel_options[i].name).text = str(wheel_options[i].count)

	if selection != -1:
		get_node("Selection").text = wheel_options[selection].name
	else:
		get_node("Selection").text = ""

	queue_redraw()


## The arc calculation function will return a PackedVector2Array with the lines
## required to draw the outline of the selected arc.
func arc_calculation() -> PackedVector2Array:
	# Calculate start and end angles for the selection, adjusted to start at 12 o'clock
	var fraction_angle = TAU * -selection / len(wheel_options)
	var start_rads = fraction_angle - (arc_angle / 2) - angle_offset
	var end_rads = fraction_angle + (arc_angle / 2) - angle_offset
	var points_per_arc = 32

	# Arrays to store points for inner and outer edges of the arc
	var points_inner = PackedVector2Array()
	var points_outer = PackedVector2Array()

	# Generate points for the arc
	for j in range(points_per_arc + 1):
		var angle = start_rads + j * (end_rads - start_rads) / points_per_arc
		points_inner.append(inner_radius * Vector2.from_angle(TAU - angle))
		points_outer.append(outer_radius * Vector2.from_angle(TAU - angle))

	# Reverse outer points to complete the arc shape correctly
	points_outer.reverse()
	return points_inner + points_outer


## Create a label object that can then be added to the scene tree.
func create_label(label_name: StringName, label_position: Vector2, count: int) -> void:
	var label_count : Label = Label.new()
	label_count.label_settings = LabelSettings.new()
	label_count.label_settings.font_color = Color.WHITE
	label_count.label_settings.font_size = 32
	label_count.position = label_position + Vector2(10, 80)
	label_count.text = str(count)
	label_count.name = label_name
	add_child(label_count)
	print('label created')
