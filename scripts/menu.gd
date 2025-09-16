extends Node2D

@onready var logo = $Logo

func _on_next_scene() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/mode_selection.tscn")
	
#Hovering
func _ready() -> void:
	var skip_p1 = Input.is_action_pressed("ok_p1")
	var skip_p2 = Input.is_action_pressed("ok_p2")
	if(skip_p1 || skip_p2):
		_on_next_scene()
