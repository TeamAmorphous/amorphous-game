extends Control

@export var offset = Vector2(-65, 65)  # Adjust this to set the distance between the PanelContainers
@export var start_position = Vector2(800, 150)  # Starting position of the first PanelContainer

func _ready():
    for i in range(get_child_count()):
        var panel = get_child(i)
        if panel is PanelContainer:
            panel.position = start_position + offset * i
