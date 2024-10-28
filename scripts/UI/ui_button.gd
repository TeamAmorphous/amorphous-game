@tool
extends Control

@export var text_content : String
signal pressed()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  $PanelContainer/MarginContainer/Button.text = text_content


func _on_button_pressed() -> void:
  pressed.emit()
