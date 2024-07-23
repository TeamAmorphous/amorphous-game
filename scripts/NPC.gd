extends StaticBody3D

# Calls the speech sprite into a variable
@onready var speech_sprite: Sprite3D = $Sprite3D/SpeechBubble

# Passing off Skuldoo to then make him sit in place while talking
var skuldoo_node : Node3D

# Y-Coordinate limits
const TOP_Y = 8.5
const BOT_Y = 6.5

#Speech bubble scaling
const speech_scale_up := Vector3(1.3, 1.3, 1.3)
# Magic numbers, I know... This is the inverse of 1.3 for scaling the speech
# bubble prompt when you get close to an NPC
const speech_scale_down := Vector3(0.76923077, 0.76923077, 0.76923077)

@onready var dialogue_window : Panel = $"../Panel"

# NPC is interactable
var player_interactable := false

# Level Controller Dialogue Signal
signal lc_init_dialogue

func _process(_delta: float) -> void:

  if Input.is_action_just_pressed("interact") and player_interactable:
    print_debug("chat enabled!!!!")
    # Lock skuldoo in place so that he doesn't leave a character talking alone
    # he's not supossed to be rude...
    skuldoo_node.in_dialogue = !skuldoo_node.in_dialogue
    lc_init_dialogue.emit()
    print(dialogue_window)
    dialogue_window.visible = !dialogue_window.visible

# Scale up speech buble when the player is nearby
func _on_talkable_area_body_entered(body:Node3D) -> void:
  print_debug(body.name)
  if body.name == 'Skuldoo':
    skuldoo_node = body
    speech_sprite.visible = true
    player_interactable = true

# Scale down speech bubble when players goes away
func _on_talkable_area_body_exited(body:Node3D) -> void:
  if body.name == 'Skuldoo':
    speech_sprite.visible = false
    player_interactable = false
