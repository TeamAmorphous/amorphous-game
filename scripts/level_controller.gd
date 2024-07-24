extends Node

# Future docstring tool?

signal lc_dialogue_concluded()

var current_dialogue_content : Array
var dialogue_paragraph_count := 0

@onready var player_char : CharacterBody3D = $"../Skuldoo"
@onready var main_dialogue_window : Label = $"../Panel/Label"


func _on_flam_lc_dialogue_initialized(text_paragraphs:Array) -> void:
  player_char.in_dialogue = true
  main_dialogue_window.get_parent().visible = true
  print_debug(text_paragraphs)
  current_dialogue_content = text_paragraphs
  main_dialogue_window.text = current_dialogue_content[dialogue_paragraph_count]

func _process(_delta: float) -> void:
  if Input.is_action_just_pressed("interact") and player_char.in_dialogue:
    next_paragraph()

func next_paragraph() -> void:
  dialogue_paragraph_count += 1
  if dialogue_paragraph_count == current_dialogue_content.size():
    end_dialogue()
  else:
    main_dialogue_window.text = current_dialogue_content[dialogue_paragraph_count]

func end_dialogue() -> void:
  player_char.in_dialogue = false
  main_dialogue_window.get_parent().visible = false
  lc_dialogue_concluded.emit()
  dialogue_paragraph_count = 0
