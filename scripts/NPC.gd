extends StaticBody3D

@onready var speech_sprite: Sprite3D = $Sprite3D/SpeechBubble
var vector_offset = Vector3(0, 0.02, 0)
var up_dir := true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

  print_debug(speech_sprite.position.y)
  speech_sprite.translate(vector_offset)

  if speech_sprite.position.y >= 8.5 or speech_sprite.position.y <= 6.5:
    vector_offset *= -1
