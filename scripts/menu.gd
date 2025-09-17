extends Node2D

@onready var logo = $Logo

func _ready() -> void:
	ThemeSong.play_song()
	GameManager.player_1_selection = ""
	GameManager.player_2_selection = ""
	GameManager.winner = ""
	GameManager.loser = ""
	GameManager.stage = ""
	
func _on_next_scene() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/mode_selection.tscn")

func _process(delta: float) -> void:
	var quit = Input.is_action_just_pressed("return")
	if quit:
		get_tree().quit()

	var skip_p1 = Input.is_action_just_pressed("ok_p1")
	var skip_p2 = Input.is_action_just_pressed("ok_p2")
	
	if skip_p1 or skip_p2:
		_on_next_scene()

func _on_logo_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/mode_selection.tscn")

func _on_logo_mouse_entered() -> void:
	logo.scale = Vector2(0.9, 0.9)

func _on_logo_mouse_exited() -> void:
	logo.scale = Vector2(0.8, 0.8)
