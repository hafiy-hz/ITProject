extends Node2D

@export var float_speed: float = 40.0
@export var fade_time: float = 0.7
@export var initial_text: String = ""

var timer: float = 0.0

func _ready():
	if $Label != null:
		$Label.text = initial_text
	else:
		print("Error: Label node not found as a child of FloatingText in _ready().")

func _process(delta):
	position.y -= float_speed * delta
	timer += delta
	if $Label != null:
		$Label.modulate.a = 1.0 - (timer / fade_time)
	if timer >= fade_time:
		queue_free()
