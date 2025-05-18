extends Node2D


func _ready() -> void:
	visible = false
	if PlayerManager.player_spawn == false:
		PlayerManager.set_player_position( global_position )
		PlayerManager.player_spawn = true
