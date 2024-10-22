@tool
extends Control

@export var numerator : String
@export var denominator : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  $HBoxContainer/PanelContainer/MarginContainer/GridContainer/high.text = numerator
  $HBoxContainer/PanelContainer/MarginContainer/GridContainer/low.text = denominator


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  $HBoxContainer/PanelContainer/MarginContainer/GridContainer/high.text = numerator
  $HBoxContainer/PanelContainer/MarginContainer/GridContainer/low.text = denominator
