extends CharacterBody2D

@export var speed: float = 500
@export var jump_force: float = -900

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var state_machine = $AnimationTree.get("parameters/playback")
@onready var collision_floor = $CollisionFloor
@onready var flip_node = $FlipNode

var in_air: bool = false
var attacking: bool = false
var current_attack: String = ""
var last_state: String = ""
var player_one: bool = true
var flip_offset = Vector2(3, 0) 
var flip_offset_2 = Vector2(70, 0) 

var key_left: String = ""
var key_right: String = ""
var key_jump: String = ""
var key_attack1: String = ""
var key_attack2: String = ""

func _ready() -> void:
	if player_one:
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

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		if not in_air:
			in_air = true
			_play_state("Jump")
	else:
		in_air = false
	
	if Input.is_action_just_pressed(key_jump) and is_on_floor():
		velocity.y = jump_force
		in_air = true
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
			collision_floor.scale.x = -1
			collision_floor.position.x = flip_offset_2.x
			$Sprite2D.scale.x = abs($Sprite2D.scale.x) * -1
		elif direction > 0:
			flip_node.scale.x = 1
			flip_node.position.x = -flip_offset.x
			collision_floor.scale.x = 1
			collision_floor.position.x = -flip_offset.x
			$Sprite2D.scale.x = abs($Sprite2D.scale.x) 
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if not attacking:
		if in_air:
			_play_state("Jump")
		else:
			if direction != 0:
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

func end_attack():
	attacking = false
	current_attack = ""

func take_hit() -> void:
	attacking = false
	current_attack = ""
	_play_state("Hit")
