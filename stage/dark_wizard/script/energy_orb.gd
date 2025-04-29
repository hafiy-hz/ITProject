class_name EnergyOrb extends Node2D


@export var speed : float = 100

var direction : Vector2 = Vector2.DOWN

func _ready():
	get_tree().create_timer( 5 ).timeout.connect( destroy )
	direction = global_position.direction_to( PlayerManager.player.global_position )
	flicker()
	pass

func _process( delta: float ) -> void:
	position += direction * speed * delta
	pass

func flicker() -> void:
	modulate.a = randf() * 0.7 + 0.3
	await get_tree().create_timer( 0.05 ).timeout
	flicker()
	pass

func destroy() -> void:
	queue_free()
