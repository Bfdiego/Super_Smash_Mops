extends Node2D

func _ready() -> void:
	ThemeSong.get_node("AudioStreamPlayer").stop()
