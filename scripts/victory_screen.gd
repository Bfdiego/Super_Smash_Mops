extends Node2D

@onready var agui_winner = $Agui_Winner
@onready var agui_loser = $Agui_Loser
@onready var diego_winner = $Diego_Winner
@onready var diego_loser = $Diego_Loser
@onready var mazen_winner = $Mazen_Winner
@onready var mazen_loser = $Mazen_Loser

@onready var agui_sprite_winner = $Agui_Winner/Sprite2D
@onready var agui_sprite_loser = $Agui_Loser/Sprite2D
@onready var diego_sprite_winner = $Diego_Winner/Sprite2D
@onready var diego_sprite_loser = $Diego_Loser/Sprite2D
@onready var mazen_sprite_winner = $Mazen_Winner/Sprite2D
@onready var mazen_sprite_loser = $Mazen_Loser/Sprite2D

func _ready() -> void:
	$AudioStreamPlayer.play()
	
	if GameManager.winner == "Agui":
		agui_winner.visible = true
	elif GameManager.winner == "Diego":
		diego_winner.visible = true
	elif GameManager.winner == "Mazen":
		mazen_winner.visible = true
	
	if GameManager.loser == "Agui":
		agui_loser.visible = true
	elif GameManager.loser == "Diego":
		diego_loser.visible = true
	elif GameManager.loser == "Mazen":
		mazen_loser.visible = true
		
	# Quitar scripts a jugadores
	agui_winner.set_script(null)
	agui_loser.set_script(null)
	diego_winner.set_script(null)
	diego_loser.set_script(null)
	mazen_winner.set_script(null)
	mazen_loser.set_script(null)

	# Flip solo en los sprites
	diego_sprite_winner.flip_h = true
	diego_sprite_loser.flip_h = true


func _process(delta: float) -> void:
	var quit = Input.is_action_just_pressed("return")
	if quit:
		get_tree().change_scene_to_file("res://scenes/menu/character_selection.tscn")
		GameManager.player_1_selection = ""
		GameManager.player_2_selection = ""
		GameManager.winner = ""
		GameManager.loser = ""
