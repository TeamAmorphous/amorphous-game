## TODO: Document code
@tool
extends Control


const SPRITE_SIZE = Vector2(32, 32)


@export var background_color : Color = Color.BLACK
@export var line_color : Color = Color.RED
@export var hightlight_color : Color = Color.GRAY

@export var outer_radius : int = 256
@export var inner_radius : int = 64
@export var line_width : int = 4

@export var options : Array[WheelOption]

var selection = 0

func _draw() -> void:
	var offset = SPRITE_SIZE / -2
	
	draw_circle(Vector2.ZERO, outer_radius, background_color)
		
	if selection == 0:
		draw_circle(Vector2.ZERO, inner_radius, hightlight_color)
	
	for i in range(1, len(options)):
		var start_rads = (TAU * (i-1) / (len(options) - 1))
		var end_rads = (TAU * i) / (len(options) - 1)
		var mid_rads = (start_rads + end_rads) / 2.0 * -1
		var radius_mid = (inner_radius + outer_radius) / 2
	
		if selection == i:
			var points_per_arc = 32
			var points_inner = PackedVector2Array()
			var points_outer = PackedVector2Array()
			
			for j in range(points_per_arc + 1):
				var angle = start_rads + j * (end_rads - start_rads) / points_per_arc
				points_inner.append(inner_radius * Vector2.from_angle(TAU - angle))
				points_outer.append(outer_radius * Vector2.from_angle(TAU - angle))
				
			points_outer.reverse()
			draw_polygon(
				points_inner + points_outer,
				PackedColorArray([hightlight_color])
				)
				
		var draw_pos =  radius_mid * Vector2.from_angle(mid_rads) + offset
		draw_texture_rect_region(
		  options[i].atlas,
		  Rect2(offset, SPRITE_SIZE),
		  options[i].region
		)
		
	draw_arc(Vector2.ZERO, inner_radius, 0, TAU, 128, line_color, line_width, true)
		
	if len(options) >= 3:
		for i in range(len(options) - 1):
			var rads = TAU * i / ((len(options) - 1))
			var point = Vector2.from_angle(rads)
			draw_line(
				point*inner_radius, 
				point*outer_radius, 
				line_color, 
				line_width, 
				true
				)
				
			
		draw_texture_rect_region(
			options[0].atlas,
			Rect2(offset, SPRITE_SIZE),
			options[0].region
			)
			
	  
func _process(delta: float) -> void:
	var mouse_pos = get_local_mouse_position()
	var mouse_radius = mouse_pos.length()
	
	if mouse_radius < inner_radius:
		selection = 0
	else:
		var mouse_rads = fposmod(mouse_pos.angle() * -1, TAU)
		selection = ceil((mouse_rads / TAU) * (len(options) - 1))
		
	print(selection)
	queue_redraw()
	