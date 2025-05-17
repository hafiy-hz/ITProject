extends Node

const PLAYER = preload("res://Player/Player.tscn")

var player : Player


func _ready() -> void:
	add_player_instance()


func add_player_instance() -> void:
	player = PLAYER.instantiate()
	add_child( player ) 
	pass

func set_health( hp: int, max_hp: int ) -> void:
	player.max_hp = max_hp
	player.hp = hp
	player.update_hp(0)
