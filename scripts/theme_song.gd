extends Node2D

@onready var player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	
	if not player.playing:
		player.play()


func play_song() -> void:
	if not player.playing:
		player.play()


func stop_song() -> void:
	if player.playing:
		player.stop()


func toggle() -> void:
	if player.playing:
		player.stop()
	else:
		player.play()
