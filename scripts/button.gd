@tool
extends PanelContainer

@export var button_text: String
@onready var button = $Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  button.text = button_text
