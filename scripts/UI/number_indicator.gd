@tool
extends Control

@export var numerator : String
@export var denominator : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$number1.text = numerator
	$number2.text = denominator


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$number1.text = numerator
	$number2.text = denominator
