extends StaticBody3D

# Calls the speech sprite into a variable
@onready var speech_sprite: Sprite3D = $Sprite3D/SpeechBubble
# Movement Vector
var vector_offset = Vector3(0, 0.02, 0)
# Y-Coordinate limits
const TOP_Y = 8.5
const BOT_Y = 6.5

func _process(_delta: float) -> void:

  speech_sprite.translate(vector_offset)

  # Flip the movement vector
  if speech_sprite.position.y >= TOP_Y or speech_sprite.position.y <= BOT_Y:
    vector_offset *= -1
