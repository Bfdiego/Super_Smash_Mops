extends Node2D

@onready var heart1_p1 = $CanvasLayer/P1heart1
@onready var heart2_p1 = $CanvasLayer/P1heart3
@onready var heart3_p1 = $CanvasLayer/P1heart2
@onready var heart1_p2 = $CanvasLayer/P2heart1
@onready var heart2_p2 = $CanvasLayer/P2heart2
@onready var heart3_p2 = $CanvasLayer/P2heart3
@onready var player1 = $MazenPlayer
@onready var player2 = $MazenPlayer2
@onready var player3 = $AguiPlayer
@onready var player4 = $AguiPlayer2
@onready var player5 = $DiegoPlayer
@onready var player6 = $DiegoPlayer2
@onready var diego_icon_p1 = $CanvasLayer/P1Avatar1
@onready var mazen_icon_p1 = $CanvasLayer/P1Avatar2
@onready var agui_icon_p1 = $CanvasLayer/P1Avatar3
@onready var diego_icon_p2 = $CanvasLayer/P2Avatar1
@onready var mazen_icon_p2 = $CanvasLayer/P2Avatar2
@onready var agui_icon_p2 = $CanvasLayer/P2Avatar3
var player_one: String = ""
var player_two: String = ""

func _ready() -> void:
	$AudioStreamPlayer.play()
	
	ThemeSong.get_node("AudioStreamPlayer").stop()
	player_one = GameManager.player_1_selection
	player_two = GameManager.player_2_selection
	
	if player_one == "Agui":
		agui_icon_p1.visible = true
		player3.visible = true
		player3.process_mode = Node.PROCESS_MODE_INHERIT
	elif player_one == "Mazen":
		mazen_icon_p1.visible = true
		player1.visible = true
		player1.process_mode = Node.PROCESS_MODE_INHERIT
	elif player_one == "Diego":
		diego_icon_p1.visible = true
		player5.visible = true
		player5.process_mode = Node.PROCESS_MODE_INHERIT
	
	if player_two == "Agui":
		agui_icon_p2.visible = true
		player4.visible = true
		player4.process_mode = Node.PROCESS_MODE_INHERIT
	elif player_two == "Mazen":
		mazen_icon_p2.visible = true
		player2.visible = true
		player2.process_mode = Node.PROCESS_MODE_INHERIT
	elif player_two == "Diego":
		diego_icon_p2.visible = true
		player6.visible = true
		player6.process_mode = Node.PROCESS_MODE_INHERIT
	
	var players = [player1, player2, player3, player4, player5, player6]
	for p in players:
		if p == null:
			continue
		p.connect("lives_changed", Callable(self, "update_hearts"))
		p.connect("player_eliminated", Callable(self, "_on_player_eliminated"))

func _process(delta: float) -> void:
	var quit = Input.is_action_just_pressed("return")
	if quit:
		get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
		GameManager.player_1_selection = ""
		GameManager.player_2_selection = ""
		GameManager.winner = ""
		GameManager.loser = ""

func update_hearts(current_lives: int, is_player_one: bool) -> void:
	
	if is_player_one:
		_update_player_hearts(current_lives, [heart1_p1, heart2_p1, heart3_p1])
	else:
		_update_player_hearts(current_lives, [heart1_p2, heart2_p2, heart3_p2])

func _update_player_hearts(lives: int, hearts: Array) -> void:
	for i in range(hearts.size()):
		hearts[i].visible = i < lives

func _on_player_eliminated(is_player_one: bool) -> void:
	print("Jugador eliminado, cambiando escena...")
	var timer = Timer.new()
	timer.wait_time = 2.0
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	get_tree().change_scene_to_file("res://scenes/stages/victory_screen.tscn")
