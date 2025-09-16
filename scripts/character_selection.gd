extends Node2D

# Player 1 Buttons
@onready var agui_selection_button_1 = $Player1Container/Agui_Selection_Button_1
@onready var diego_selection_button_1 = $Player1Container/Diego_Selection_Button_1
@onready var mazen_selection_button_1 = $Player1Container/Mazen_Selection_Button_1
@onready var random_selection_button_1 = $Player1Container/Random_Selection_Button_1

# Player 2 Buttons
@onready var agui_selection_button_2 = $Player2Container/Agui_Selection_Button_2
@onready var diego_selection_button_2 = $Player2Container/Diego_Selection_Button_2
@onready var mazen_selection_button_2 = $Player2Container/Mazen_Selection_Button_2
@onready var random_selection_button_2 = $Player2Container/Random_Selection_Button_2

# Player 1 Frames
@onready var agui_selection_button_1_frame = $Player1Container/Agui_Selection_Button_1/Agui_frame_1
@onready var diego_selection_button_1_frame = $Player1Container/Diego_Selection_Button_1/Diego_frame_1
@onready var mazen_selection_button_1_frame = $Player1Container/Mazen_Selection_Button_1/Mazen_frame_1
@onready var random_selection_button_1_frame = $Player1Container/Random_Selection_Button_1/Random_frame_1

# Player 2 Frames
@onready var agui_selection_button_2_frame = $Player2Container/Agui_Selection_Button_2/Agui_frame_2
@onready var diego_selection_button_2_frame = $Player2Container/Diego_Selection_Button_2/Diego_frame_2
@onready var mazen_selection_button_2_frame = $Player2Container/Mazen_Selection_Button_2/Mazen_frame_2
@onready var random_selection_button_2_frame = $Player2Container/Random_Selection_Button_2/Random_frame_2

# Labels
@onready var player_1_label = $Player_1_Label
@onready var player_2_label = $Player_2_Label

# Players
@onready var agui_player_1 = $Agui_Player_1
@onready var agui_player_2 = $Agui_Player_2
@onready var diego_player_1 = $Diego_Player_1
@onready var diego_player_2 = $Diego_Player_2
@onready var mazen_player_1 = $Mazen_Player_1
@onready var mazen_player_2 = $Mazen_Player_2

# Sprites internos (solo para flip)
@onready var agui_sprite_1 = $Agui_Player_1/Sprite2D
@onready var agui_sprite_2 = $Agui_Player_2/Sprite2D
@onready var diego_sprite_1 = $Diego_Player_1/Sprite2D
@onready var diego_sprite_2 = $Diego_Player_2/Sprite2D
@onready var mazen_sprite_1 = $Mazen_Player_1/Sprite2D
@onready var mazen_sprite_2 = $Mazen_Player_2/Sprite2D

var characters = ["Agui", "Diego", "Mazen"]

func _ready() -> void:
	agui_selection_button_1_frame.visible = false 
	diego_selection_button_1_frame.visible = false 
	mazen_selection_button_1_frame.visible = false 
	random_selection_button_1_frame.visible = false 
	agui_selection_button_2_frame.visible = false 
	diego_selection_button_2_frame.visible = false 
	mazen_selection_button_2_frame.visible = false 
	random_selection_button_2_frame.visible = false
	
	agui_player_1.visible = false
	diego_player_1.visible = false
	mazen_player_1.visible = false
	agui_player_2.visible = false
	diego_player_2.visible = false
	mazen_player_2.visible = false

	# Quitar scripts a jugadores
	agui_player_1.set_script(null)
	diego_player_1.set_script(null)
	mazen_player_1.set_script(null)
	agui_player_2.set_script(null)
	diego_player_2.set_script(null)
	mazen_player_2.set_script(null)

	# Flip solo en los sprites
	agui_sprite_1.flip_h = true
	diego_sprite_2.flip_h = true
	mazen_sprite_1.flip_h = true

func lock_in_selection(player: int, character: String) -> void:
	if player == 1:
		GameManager.player_1_selection = character
		_show_frame(character, 1)
		_disable_button(characters[0], 1)
		_disable_button(characters[1], 1)
		_disable_button(characters[2], 1)
		_disable_button(character, 2)
	elif player == 2:
		GameManager.player_2_selection = character
		_show_frame(character, 2)
		_disable_button(characters[0], 2)
		_disable_button(characters[1], 2)
		_disable_button(characters[2], 2)
		_disable_button(character, 1)
		
	if GameManager.player_1_selection != "" and GameManager.player_2_selection != "":
		get_tree().change_scene_to_file("res://scenes/menu/stage_selection.tscn")

func _show_hover_player(player: int, character: String) -> void:
	# Si ya hay selección y no es Random, no ocultamos al seleccionado
	var selected = ""
	if player == 1:
		selected = GameManager.player_1_selection
	elif player == 2:
		selected = GameManager.player_2_selection
	
	if selected != "" and selected != "Random":
		# Si ya se seleccionó un jugador válido, solo ese permanece visible
		return
	
	# Ocultar todos primero
	_hide_all_players(player)
	
	# Mostrar solo el que tiene el mouse encima
	match [player, character]:
		[1, "Agui"]: agui_player_1.visible = true
		[1, "Diego"]: diego_player_1.visible = true
		[1, "Mazen"]: mazen_player_1.visible = true
		[2, "Agui"]: agui_player_2.visible = true
		[2, "Diego"]: diego_player_2.visible = true
		[2, "Mazen"]: mazen_player_2.visible = true

func _show_frame(character: String, player: int) -> void:
	var frame
	match [character, player]:
		["Agui", 1]: frame = agui_selection_button_1_frame
		["Diego", 1]: frame = diego_selection_button_1_frame
		["Mazen", 1]: frame = mazen_selection_button_1_frame
		["Random", 1]: frame = random_selection_button_1_frame
		["Agui", 2]: frame = agui_selection_button_2_frame
		["Diego", 2]: frame = diego_selection_button_2_frame
		["Mazen", 2]: frame = mazen_selection_button_2_frame
		["Random", 2]: frame = random_selection_button_2_frame
	if frame:
		frame.visible = true

func _disable_button(character: String, player: int) -> void:
	var button
	match [character, player]:
		["Agui", 1]: button = agui_selection_button_1
		["Diego", 1]: button = diego_selection_button_1
		["Mazen", 1]: button = mazen_selection_button_1
		["Random", 1]: button = random_selection_button_1
		["Agui", 2]: button = agui_selection_button_2
		["Diego", 2]: button = diego_selection_button_2
		["Mazen", 2]: button = mazen_selection_button_2
		["Random", 2]: button = random_selection_button_2
	if button:
		button.disabled = true
		button.modulate = Color(0.5, 0.5, 0.5)

func _hide_all_players(player: int) -> void:
	if player == 1:
		agui_player_1.visible = false
		diego_player_1.visible = false
		mazen_player_1.visible = false
	elif player == 2:
		agui_player_2.visible = false
		diego_player_2.visible = false
		mazen_player_2.visible = false

func _pick_random(excluded: String) -> String:
	var pool = characters.duplicate()
	pool.erase(excluded)
	return pool[randi() % pool.size()]

# Player 1
func _on_agui_selection_button_1_pressed() -> void: 
	lock_in_selection(1, "Agui")
	
func _on_diego_selection_button_1_pressed() -> void: 
	lock_in_selection(1, "Diego")
	
func _on_mazen_selection_button_1_pressed() -> void: 
	lock_in_selection(1, "Mazen")
	
func _on_random_selection_button_1_pressed() -> void:
	var chosen = _pick_random(GameManager.player_2_selection)
	lock_in_selection(1, chosen)

# Player 2
func _on_agui_selection_button_2_pressed() -> void: 
	lock_in_selection(2, "Agui")
	
func _on_diego_selection_button_2_pressed() -> void: 
	lock_in_selection(2, "Diego")
	
func _on_mazen_selection_button_2_pressed() -> void: 
	lock_in_selection(2, "Mazen")
	
func _on_random_selection_button_2_pressed() -> void:
	var chosen = _pick_random(GameManager.player_1_selection)
	lock_in_selection(2, chosen)

func _on_agui_selection_button_1_mouse_entered() -> void: 
	if !agui_selection_button_1.disabled:
		agui_selection_button_1_frame.visible = true
		player_1_label.text = "Agui"
		_show_hover_player(1, "Agui")
	
func _on_agui_selection_button_1_mouse_exited() -> void: 
	if !agui_selection_button_1.disabled: 
		agui_selection_button_1_frame.visible = false

func _on_diego_selection_button_1_mouse_entered() -> void: 
	if !diego_selection_button_1.disabled:
		diego_selection_button_1_frame.visible = true
		player_1_label.text = "Diego"
		_show_hover_player(1, "Diego")
	
func _on_diego_selection_button_1_mouse_exited() -> void: 
	if !diego_selection_button_1.disabled: 
		diego_selection_button_1_frame.visible = false

func _on_mazen_selection_button_1_mouse_entered() -> void:
	if !mazen_selection_button_1.disabled:
		mazen_selection_button_1_frame.visible = true
		player_1_label.text = "Mazen"
		_show_hover_player(1, "Mazen")
	
func _on_mazen_selection_button_1_mouse_exited() -> void: 
	if !mazen_selection_button_1.disabled: 
		mazen_selection_button_1_frame.visible = false

func _on_random_selection_button_1_mouse_entered() -> void: 
	if !random_selection_button_1.disabled: 
		random_selection_button_1_frame.visible = true
		player_1_label.text = "Random"
		
func _on_random_selection_button_1_mouse_exited() -> void: 
	if !random_selection_button_1.disabled: 
		random_selection_button_1_frame.visible = false

# Player 2
func _on_agui_selection_button_2_mouse_entered() -> void: 
	if !agui_selection_button_2.disabled: 
		agui_selection_button_2_frame.visible = true
		player_2_label.text = "Agui"
		_show_hover_player(2, "Agui")
	
func _on_agui_selection_button_2_mouse_exited() -> void: 
	if !agui_selection_button_2.disabled: 
		agui_selection_button_2_frame.visible = false

func _on_diego_selection_button_2_mouse_entered() -> void: 
	if !diego_selection_button_2.disabled: 
		diego_selection_button_2_frame.visible = true
		player_2_label.text = "Diego"
		_show_hover_player(2, "Diego")
	
func _on_diego_selection_button_2_mouse_exited() -> void: 
	if !diego_selection_button_2.disabled: 
		diego_selection_button_2_frame.visible = false

func _on_mazen_selection_button_2_mouse_entered() -> void: 
	if !mazen_selection_button_2.disabled: 
		mazen_selection_button_2_frame.visible = true
		player_2_label.text = "Mazen"
		_show_hover_player(2, "Mazen")
	
func _on_mazen_selection_button_2_mouse_exited() -> void: 
	if !mazen_selection_button_2.disabled:
		mazen_selection_button_2_frame.visible = false

func _on_random_selection_button_2_mouse_entered() -> void: 
	if !random_selection_button_2.disabled: 
		random_selection_button_2_frame.visible = true
		player_2_label.text = "Random"
	
func _on_random_selection_button_2_mouse_exited() -> void: 
	if !random_selection_button_2.disabled: 
		random_selection_button_2_frame.visible = false
