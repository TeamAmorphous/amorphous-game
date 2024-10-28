extends StaticBody3D

# TODO: Docstrings at some point

# Level Controller Dialogue Signal
signal lc_dialogue_initialized(text_paragraphs : Array)

# NPC is interactable
var player_interactable := false
# Paragraph dialogue test
var line1 := "line1"
var line2 := "line2"
var line3 := "line3"
var paragraphs := [line1, line2, line3]

# Calls the speech sprite into a variable
@onready var speech_sprite: Sprite3D = $Sprite3D/SpeechBubble
@onready var dialogue_window : Panel = $"../Panel"


func _process(_delta: float) -> void:

  if Input.is_action_just_pressed("interact") and player_interactable:
    print_debug("chat enabled!!!!")
    # TODO: Lock skuldoo in place so that he doesn't leave a character talking
    # alone he's not supossed to be rude...

    #skuldoo_node.in_dialogue = !skuldoo_node.in_dialogue
    #dialogue_window.visible = !dialogue_window.visible
    print(dialogue_window)
    player_interactable = false
    speech_sprite.visible = false
    lc_dialogue_initialized.emit(paragraphs)

# Scale up speech buble when the player is nearby
func _on_talkable_area_body_entered(body:Node3D) -> void:
  print_debug(body.name)
  if body.name == "Skuldoo":
    speech_sprite.visible = true
    player_interactable = true

# Scale down speech bubble when players goes away
func _on_talkable_area_body_exited(body:Node3D) -> void:
  if body.name == "Skuldoo":
    speech_sprite.visible = false
    player_interactable = false

func _on_level_controller_lc_dialogue_concluded() -> void:
  print_debug("dialogue concluded")
  await get_tree().create_timer(.1).timeout
  player_interactable = true
  speech_sprite.visible = true
