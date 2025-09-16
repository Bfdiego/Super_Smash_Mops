extends Node2D

@onready var postgraduate_button = $Postgraduate_Selection_Button
@onready var postgraduate_background = $Postgraduate_Background
@onready var campus_button = $Campus_Selection_Button
@onready var campus_background = $Campus_Background

func _on_campus_selection_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/stages/upb_campus.tscn")

func _on_postgraduate_selection_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/stages/upb_postgraduate.tscn")

func _process(delta: float) -> void:
	var quit = Input.is_action_just_pressed("return")
	if quit:
		get_tree().change_scene_to_file("res://scenes/menu/character_selection.tscn")
		GameManager.player_1_selection = ""
		GameManager.player_2_selection = ""
#Hovering
func _on_campus_selection_button_mouse_entered() -> void:
	campus_button.scale = Vector2(0.3, 0.3)
	campus_background.visible = true
	postgraduate_background.visible = false

func _on_campus_selection_button_mouse_exited() -> void:
	campus_button.scale = Vector2(0.25, 0.25)

func _on_postgraduate_selection_button_mouse_entered() -> void:
	postgraduate_button.scale = Vector2(0.3, 0.3)
	postgraduate_background.visible = true
	campus_background.visible = false

func _on_postgraduate_selection_button_mouse_exited() -> void:
	postgraduate_button.scale = Vector2(0.25, 0.25)
