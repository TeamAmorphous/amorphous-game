extends Control


func _on_new_game_pressed() -> void:
  get_tree().change_scene_to_file("res://scenes/Forest.tscn")


func _on_load_game_pressed() -> void:
  get_tree().change_scene_to_file("res://scenes/Forest.tscn")


func _on_quit_pressed() -> void:
  get_tree().quit()

