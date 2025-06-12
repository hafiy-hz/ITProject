extends Sprite2D

@export var speed : float = 450


var rect : Rect2

func _ready() -> void:
	rect = self.region_rect



func _process(delta: float) -> void:
	region_rect.position += Vector2( speed * delta, 0 )

#@export var speed : float = 450
#@export var damage : int = 10  # Damage amount

#var rect : Rect2
#var can_damage : bool = false

#func _ready() -> void:
	#rect = self.region_rect
	# Add to the "enemy_attack" group for collision detection
	#add_to_group("enemy_attack")

#func _process(delta: float) -> void:
	#mregion_rect.position += Vector2( speed * delta, 0 )
	
	# Only check for damage when the beam is visible
	#if visible and can_damage:
		#check_player_collision()

#func check_player_collision() -> void:
	#var bodies = get_overlapping_bodies()
	#for body in bodies:
		#if body.is_in_group("player"):
			#if body.has_method("take_damage"):
				#body.take_damage(damage)
				# Optional: Add a cooldown to prevent multiple hits
				#can_damage = false
				#await get_tree().create_timer(0.5).timeout
				#can_damage = true
