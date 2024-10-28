extends Control

signal items_pressed()
signal flee_pressed()
signal attacks_pressed()
signal gear_pressed()


# Called when the node enters the sckene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_items_pressed() -> void:
	items_pressed.emit() # Replace with function body.


func _on_flee_pressed() -> void:
	flee_pressed.emit() # Replace with function body.


func _on_attacks_pressed() -> void:
	attacks_pressed.emit() # Replace with function body.


func _on_gear_pressed() -> void:
	gear_pressed.emit() # Replace with function body.


