extends Node2D

func _ready() -> void:
	$Loading.visible = true
	$Loading.process_mode = Node.PROCESS_MODE_ALWAYS
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file(GameManager.stage)
