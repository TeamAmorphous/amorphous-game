extends StaticBody3D

# Calls the speech sprite into a variable
@onready var speech_sprite: Sprite3D = $Sprite3D/SpeechBubble

# Movement Vector
var vector_offset := Vector3(0, 0.02, 0)

# Y-Coordinate limits
const TOP_Y = 8.5
const BOT_Y = 6.5

#Speech bubble scaling
const speech_scale_up := Vector3(1.3, 1.3, 1.3)
const speech_scale_down := Vector3(0.76923077, 0.76923077, 0.76923077)

# NPC is interactable
var player_interactable := false

func _process(_delta: float) -> void:

  #Move speech bubble
  speech_sprite.translate(vector_offset)

  # Flip the movement vector
  if speech_sprite.position.y >= TOP_Y or speech_sprite.position.y <= BOT_Y:
    vector_offset *= -1
  if Input.is_action_just_pressed("interact") and player_interactable:
    print("chat enabled!!!!")

# Scale up speech buble when the player is nearby
func _on_talkable_area_body_entered(body:Node3D) -> void:
  print_debug(body.name)
  if body.name == 'Skuldoo':
    speech_sprite.scale_object_local(speech_scale_up)
    player_interactable = true

# Scale down speech bubble when players goes away
func _on_talkable_area_body_exited(body:Node3D) -> void:
  if body.name == 'Skuldoo':
    speech_sprite.scale_object_local(speech_scale_down)
    player_interactable = false
