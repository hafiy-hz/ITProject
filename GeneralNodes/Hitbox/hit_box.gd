class_name  HitBox extends Node

signal Damage( damage : int )

func _ready():
	pass
	
	
func _process(delta):
	pass
	
	
func TakeDamage( damage : int ) -> void:
	print( "takeDamage: ", damage )
	Damage.emit( damage )
