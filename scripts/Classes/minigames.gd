class_name Minigame
extends Node

## TODO: Class Documentation

signal minigame_started()
signal minigame_finished()

var attacker : Node3D
var target : Node3D
var _ui_node : Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
