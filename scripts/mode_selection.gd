extends Node2D

@onready var single_player_button = $Single_Player_Button
@onready var multi_player_button = $Multi_Player_Button
@onready var single_player = $SinglePlayer
@onready var multi_player = $MultiPlayer
@onready var multi_player2 = $MultiPlayer2

func _on_single_player_button_pressed() -> void:
	print("Project still in development\n Single Player mode not ready yet!")

func _on_multi_player_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/character_selection.tscn")

func _on_single_player_button_mouse_entered() -> void:
	single_player_button.scale = Vector2(0.6, 0.6)
	single_player.visible = true

func _on_single_player_button_mouse_exited() -> void:
	single_player_button.scale = Vector2(0.5, 0.5)
	single_player.visible = false

func _on_multi_player_button_mouse_entered() -> void:
	multi_player_button.scale = Vector2(0.6, 0.6)
	multi_player.visible = true
	multi_player2.visible = true

func _on_multi_player_button_mouse_exited() -> void:
	multi_player_button.scale = Vector2(0.5, 0.5)
	multi_player.visible = false
	multi_player2.visible = false
