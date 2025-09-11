extends CharacterBody2D

@export var speed: float = 500
@export var jump_force: float = -500


var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var state_machine = $AnimationTree.get("parameters/playback")

func _physics_process(delta: float) -> void:
	# add gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		state_machine.travel("Jump")
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force
		state_machine.travel("Jump")
		
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
		state_machine.travel("Walk")
		if direction < 0:
			$Sprite2D.scale.x = abs($Sprite2D.scale.x) 
		elif direction > 0:
			$Sprite2D.scale.x = abs($Sprite2D.scale.x) * -1
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		state_machine.travel("Idle")
		
	move_and_slide()
