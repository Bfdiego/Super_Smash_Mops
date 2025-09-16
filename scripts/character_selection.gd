extends Node2D

@onready var agui_selection_button = $Agui_Selection_Button
@onready var diego_selection_button = $Diego_Selection_Button
@onready var mazen_selection_button = $Mazen_Selection_Button
@onready var random_selection_button = $Random_Selection_Button

func _on_agui_selection_button_pressed() -> void:
	pass
	#if player1 && GameManager.player2 != "Agui":
	#	GameManager.player1 = "Agui"
	#else if player2 && GameManager.player1 != "Agui":
	#	GameManager.player2 = "Agui"

func _on_diego_selection_button_pressed() -> void:
	pass
	#if player1 && GameManager.player2 != "Diego":
	#	GameManager.player1 = "Diego"
	#else if player2 && GameManager.player1 != "Diego":
	#	GameManager.player2 = "Diego"

func _on_mazen_selection_button_pressed() -> void:
	pass
	#if player1 && GameManager.player2 != "Mazen":
	#	GameManager.player1 = "Mazen"
	#else if player2 && GameManager.player1 != "Mazen":
	#	GameManager.player2 = "Mazen"

func _on_random_selection_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/stage_selection.tscn")

#Hovering
func _on_agui_selection_button_mouse_entered() -> void:
	agui_selection_button.scale = Vector2(0.3, 0.3)

func _on_agui_selection_button_mouse_exited() -> void:
	agui_selection_button.scale = Vector2(0.25, 0.25)

func _on_diego_selection_button_mouse_entered() -> void:
	diego_selection_button.scale = Vector2(0.3, 0.3)

func _on_diego_selection_button_mouse_exited() -> void:
	diego_selection_button.scale = Vector2(0.25, 0.25)

func _on_mazen_selection_button_mouse_entered() -> void:
	mazen_selection_button.scale = Vector2(0.3, 0.3)

func _on_mazen_selection_button_mouse_exited() -> void:
	mazen_selection_button.scale = Vector2(0.25, 0.25)

func _on_random_selection_button_mouse_entered() -> void:
	random_selection_button.scale = Vector2(0.3, 0.3)

func _on_random_selection_button_mouse_exited() -> void:
	random_selection_button.scale = Vector2(0.25, 0.25)
