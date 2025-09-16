extends CharacterBody2D

@export var speed: float = 500
@export var jump_force: float = -900

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var state_machine = $AnimationTree.get("parameters/playback")
@onready var flip_node = $FlipNode

var in_air: bool = false
var attacking: bool = false
var current_attack: String = ""
var last_state: String = ""
signal player_eliminated(is_player_one)
signal lives_changed(current_lives, is_player_one)
@export var is_player_one: bool
var flip_offset = Vector2(3, 0) 
var flip_offset_2 = Vector2(40, 0) 
var flip_offset_p = Vector2(40, 0) 

var key_left: String = ""
var key_right: String = ""
var key_jump: String = ""
var key_attack1: String = ""
var key_attack2: String = ""

@export var max_lives = 3
var current_lives: int
var respawn_point: Vector2 = Vector2.ZERO
var is_invulnerable: bool = false
var knockback_force: float = 800.0

var hit_timer: float = 0.0
var hit_duration: float = 0.4
var jump_buffer: bool = false

@export var max_air_jumps: int = 1
var air_jumps_left: int = 0

func _ready() -> void:
	var namep1 = GameManager.player_1_selection
	var namep2 = GameManager.player_2_selection
	if  namep1 == "Diego":
		is_player_one = true
	elif namep2 == "Diego":
		is_player_one = false
	if is_player_one:
		key_left = "left_p1"
		key_right = "right_p1"
		key_jump = "jump_p1"
		key_attack1 = "attack1_p1"
		key_attack2 = "attack2_p1"
	else:
		key_left = "left_p2"
		key_right = "right_p2"
		key_jump = "jump_p2"
		key_attack1 = "attack1_p2"
		key_attack2 = "attack2_p2"
	
	current_lives = max_lives
	respawn_point = global_position
	$FlipNode/HitBox.set_meta("force", 400.0)
	$FlipNode/HitBox2.set_meta("force", 900.0)
	$FlipNode/HitBox.set_meta("name", "Diego")
	$FlipNode/HitBox2.set_meta("name", "Diego")

func _physics_process(delta: float) -> void:
	if global_position.y > 1200:
		die()
	
	if hit_timer > 0:
		hit_timer -= delta
		velocity.y += gravity * delta
		move_and_slide()
		return
	
	if not is_on_floor():
		velocity.y += gravity * delta
		if not in_air:
			in_air = true
			if not attacking and hit_timer <= 0:
				enter_jump_state()
	else:
		air_jumps_left = max_air_jumps
		if in_air:
			in_air = false
			jump_buffer = false
			if not attacking and hit_timer <= 0:
				if velocity.x != 0:
					_play_state("Run")
				else:
					_play_state("Idle")
	
	if Input.is_action_just_pressed(key_jump):
		if is_on_floor():
			velocity.y = jump_force
			in_air = true
			if not attacking and hit_timer <= 0:
				enter_jump_state()
		elif air_jumps_left > 0:
			air_jumps_left -= 1
			velocity.y = jump_force
			if not attacking and hit_timer <= 0:
				_play_state("Jump")
	
	if not attacking:
		if in_air and (Input.is_action_just_pressed(key_attack1) or Input.is_action_just_pressed(key_attack2)):
			_start_attack("Attack3")
		elif not in_air and Input.is_action_just_pressed(key_attack1):
			_start_attack("Attack1")
		elif not in_air and Input.is_action_just_pressed(key_attack2):
			_start_attack("Attack2")

	var direction = Input.get_axis(key_left, key_right)
	if direction != 0:
		velocity.x = direction * speed
		
		if direction < 0:
			flip_node.scale.x = -1
			flip_node.position.x = flip_offset_2.x
			$Sprite2D.scale.x = abs($Sprite2D.scale.x) * -1
			$Sprite2D.position.x = -flip_offset.x
		elif direction > 0:
			flip_node.scale.x = 1
			flip_node.position.x = -flip_offset.x
			$Sprite2D.scale.x = abs($Sprite2D.scale.x) 
			$Sprite2D.position.x = flip_offset_p.x
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if not attacking and not in_air and hit_timer <= 0:
		if velocity.x != 0:
			_play_state("Run")
		else:
			_play_state("Idle")
	
	move_and_slide()

func _play_state(state: String) -> void:
	if state != last_state:
		state_machine.travel(state)
		last_state = state

func _start_attack(attack_name: String) -> void:
	attacking = true
	current_attack = attack_name
	_play_state(attack_name)
	
	match attack_name:
		"Attack1":
			$FlipNode/HitBox.set_meta("force", 400.0)
		"Attack2":
			$FlipNode/HitBox.set_meta("force", 600.0)
		"Attack3":
			$FlipNode/HitBox2.set_meta("force", 900.0)
	
	print("Lanzó ", attack_name, " con fuerza ", $FlipNode/HitBox.get_meta("force"))

func end_attack():
	attacking = false
	current_attack = ""
	if in_air:
		jump_buffer = false
		enter_jump_state()

func take_hit() -> void:
	attacking = false
	current_attack = ""
	_play_state("Hit")
	hit_timer = hit_duration

func apply_knockback(from_direction: int, attack_force: float) -> void:
	if is_invulnerable:
		print("Golpe ignorado por invulnerabilidad")
		return

	var multiplier = (4 - current_lives)
	var total_force = attack_force + knockback_force * multiplier

	velocity.x = from_direction * total_force * -1
	velocity.y = -300

	print("Recibió knockback:", total_force, " | Vidas:", current_lives)
	take_hit()

func die() -> void:
	current_lives -= 1
	print("Jugador " + ("1" if is_player_one else "2") + " murió. Vidas restantes: " + str(current_lives))

	emit_signal("lives_changed", current_lives, is_player_one)
	if current_lives <= 0:
		print("Jugador" + ("1" if is_player_one else "2") + "fue eliminado!")
		emit_signal("player_eliminated", is_player_one)
		queue_free()
	else:
		respawn()

func respawn() -> void:
	global_position = respawn_point
	velocity = Vector2.ZERO
	is_invulnerable = true
	print("Jugador" + ("1" if is_player_one else "2") + "respawneó con invulnerabilidad")

	await get_tree().create_timer(2.0).timeout
	is_invulnerable = false
	print("Invulnerabilidad terminada")


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("PlayerHitBox") or true:
		var attacker = area.get_owner()
		if attacker != self:
			var force := 400.0
			if area.has_meta("force"):
				force = area.get_meta("force")
			
			print("Fui golpeado por ", attacker.name, " con fuerza ", force)
			var name
			if area.has_meta("name"):
				name = area.get_meta("name")
				if name == "Mazen":
					apply_knockback(attacker.flip_node.scale.x, force)
				if name == "Agui":
					apply_knockback(attacker.flip_node.scale.x, force)

func enter_jump_state() -> void:
	if not attacking and not jump_buffer:
		_play_state("Jump")
		jump_buffer = true
