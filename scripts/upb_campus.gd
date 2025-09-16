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

func _ready() -> void:
	ThemeSong.get_node("AudioStreamPlayer").stop()

	var players = [player1, player2, player3, player4, player5, player6]
	for p in players:
		if p == null:
			continue
		p.connect("lives_changed", Callable(self, "update_hearts"))
		

func update_hearts(current_lives: int, is_player_one: bool) -> void:
	
	if is_player_one:
		_update_player_hearts(current_lives, [heart1_p1, heart2_p1, heart3_p1])
	else:
		_update_player_hearts(current_lives, [heart1_p2, heart2_p2, heart3_p2])

func _update_player_hearts(lives: int, hearts: Array) -> void:
	for i in range(hearts.size()):
		hearts[i].visible = i < lives
