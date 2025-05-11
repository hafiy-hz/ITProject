class_name BeamAttack extends Node

@export var use_timer : bool = false
@export var time_between_attack : float = 20


@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	if use_timer == true:
		attack_delay()
	pass
	
func attack() -> void:
	animation_player.play( "attack" )
	await animation_player.animation_finished
	animation_player.play( "default" )
	if use_timer == true:
		attack_delay()


func attack_delay() -> void:
	await get_tree().create_timer( time_between_attack ).timeout
	attack()
