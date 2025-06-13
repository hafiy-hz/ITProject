extends Node2D


func _ready() -> void:
	#visible = false
	#if PlayerManager.player_spawn == false:
		#PlayerManager.set_player_position( global_position )
		#PlayerManager.player_spawn = true
		#visible = false
	if PlayerManager.is_in_game and not PlayerManager.player_spawn:
		PlayerManager.set_player_position(global_position)
		PlayerManager.player_spawn = true
