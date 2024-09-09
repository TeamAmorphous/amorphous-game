extends Node3D

signal cog_battle_scene_called()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	print_debug(body.name)
	if body.name == "Skuldoo":
		print_debug("Fight!")
		GlobalVariables.current_battle_init = randi_range(0,2)
		print_debug(GlobalVariables.current_battle_init)
		cog_battle_scene_called.emit()


func _on_cog_battle_scene_called() -> void:
	get_tree().change_scene_to_file.call_deferred("res://scenes/Battle.tscn")
