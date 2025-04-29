class_name HurtBox extends Node


@export var damage : int = 5

func _ready():
	area_entered.connect( AreaEntered )
	pass
	
func AreaEntered( a : Area2D ) -> void:
	if a is HitBox:
		a.TakeDamage( damage )
	pass
