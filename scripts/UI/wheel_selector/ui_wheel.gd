## TODO: Document code
@tool
extends Control

# TODO: Add item count on corner of sprite

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
var angle_offset = -(PI/2)
var arc_angle

func _draw() -> void:
	# Offset position for centering sprites
	var offset = sprite_size / -2

	# Draw Background Circle
	draw_circle(Vector2.ZERO, outer_radius + background_offset, background_color)

	# Draw Highlight Arc if a selection is made
	var arc : PackedVector2Array = arc_calculation()
	if selection != -1:
		draw_polygon(
			arc,
			PackedColorArray([hightlight_color])
		)

	# Draw sprites & lines
	for i in range(len(options)):
		var mid_rads = ((TAU/len(options)) * i) + angle_offset
		var radius_mid = (inner_radius + outer_radius) / 2
		var draw_pos = radius_mid * Vector2.from_angle(mid_rads) + offset
		if i != selection:
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
				options[i].region
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

	# Draw Outer Circle Line
	draw_arc(Vector2.ZERO, outer_radius, 0, TAU, 128, line_color, line_width)

	# Draw Inner Circle Line
	draw_arc(Vector2.ZERO, inner_radius, 0, TAU, 128, line_color, line_width)

	# Draw Highlight Line & Selection Outline if selected
	if selection != -1:
		draw_circle(Vector2.ZERO, inner_radius + 5, selection_outline_color)

		# Close the arc by connecting the last point to the first for smoothness
		draw_polyline(
			arc + arc.slice(0,1),
			selection_outline_color,
			highlighted_line_width
		)

		# Draw selected item sprite at the center for highlight
		draw_texture_rect_region(
			options[selection].atlas,
			Rect2(Vector2.ZERO + offset + Vector2(0, -25), sprite_size),
			options[selection].region
		)

func _ready() -> void:
	var offset = sprite_size / -2
	for i in len(options):
		var mid_rads = ((TAU/len(options)) * i) + angle_offset
		var radius_mid = (inner_radius + outer_radius) / 2
		var draw_pos = radius_mid * Vector2.from_angle(mid_rads) + offset
		create_label(options[i].name, draw_pos, options[i].count)


func _process(_delta: float) -> void:
	arc_angle = (TAU / len(options))
	var mouse_pos = get_local_mouse_position()
	var mouse_radius = mouse_pos.length()
	if mouse_radius > outer_radius:
		selection = -1
	else:
		var mouse_rads = fposmod((mouse_pos.angle_to(Vector2(0,-1)) - (arc_angle / 2)) * -1, TAU)
		selection = floor((mouse_rads / TAU) * (len(options)))

	line_color = options[selection].color
	hightlight_color = line_color - Color(0, 0, 0, .5)
	selection_outline_color = line_color + Color(0.3, 0.3, 0.3, 1)

	get_node("Selection").set("theme_override_colors/font_color", line_color - Color(0.5, 0.5, 0.5, 0))

	for i in range(len(options)):
		update_label(options[i].name, options[i].count)

	if selection != -1:
		get_node("Selection").text = options[selection].name
	else:
		get_node("Selection").text = ""
	queue_redraw()


func arc_calculation() -> PackedVector2Array:
	# Calculate start and end angles for the selection, adjusted to start at 12 o'clock
	var fraction_angle = TAU * -selection / len(options)
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


func update_label(label_name: String, updated_count: int):
	get_node(label_name).text = str(updated_count)
