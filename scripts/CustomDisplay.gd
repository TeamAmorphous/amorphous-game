@tool
extends Control

@export_category("Button Properties")
@export var line_color: Color = Color.ORANGE
@export var line_thickness: float = 3.0

var base_coords : Array = [
  [ 0, 0 ],
  [ 200, 0 ],
  [ 150, 50 ],
  [ -50, 50 ],
  [ 0, 0 ]
]

var lines : PackedVector2Array
var block : PackedVector2Array

func float_array_to_Vector2Array(coords : Array) -> PackedVector2Array:
  # Convert the array of floats into a PackedVector2Array.
  var array : PackedVector2Array = []
  for coord in coords:
	array.append(Vector2(coord[0], coord[1]))
  return array

func generate_block_coords(base_coords : Array) -> PackedVector2Array:
  var offsets : Array = [[-10, -10],[0, 0],[0, 0],[0, 0],[0, 0]]
  var block_coords : PackedVector2Array = []
  for i in offsets.size():
	block_coords.append(Vector2(base_coords[i][0] + offsets[i][0], base_coords[i][1] + offsets[i][1]))
  return block_coords

func _draw() -> void:
  draw_polygon(block, [ Color.BLACK ] )
  draw_polyline(lines, line_color, 1.5)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  lines = float_array_to_Vector2Array(base_coords);
  block = generate_block_coords(base_coords)
  
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  pass
