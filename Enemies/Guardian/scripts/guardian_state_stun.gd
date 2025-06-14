class_name GuardianStateStun extends GuardianState

@export var anim_name : String = "stun"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10

@export_category("AI")
@export var next_state : GuardianState

var _damage_position : Vector2
var _direction : Vector2
var _animation_finished : bool = false

func init() -> void:
	guardian.guardian_damaged.connect( _on_guardian_damaged )
	pass

func enter() -> void:
	guardian.invulnerable = true 
	_animation_finished = false
	
	_direction = guardian.global_position.direction_to( _damage_position )
	
	
	_direction = guardian.global_position.direction_to( guardian.player.global_position )
	
	guardian.set_direction( _direction )
	guardian.velocity = _direction * -knockback_speed
	
	guardian.update_animation( anim_name )
	guardian.animation_player.animation_finished.connect( _on_animation_finished )
	pass 

func exit() -> void:
	guardian.invulnerable = false
	guardian.animation_player.animation_finished.disconnect( _on_animation_finished )
	pass



func process(_delta: float) -> GuardianState:
	# Only allow transition if animation is finished AND NOT in Destroy state
	if _animation_finished and not (state_machine.current_state is GuardianStateDestroy):
		return next_state
	
	# Continue with other behavior like velocity damping (optional)
	guardian.velocity -= guardian.velocity * decelerate_speed * _delta
	
	return null


func physics( _delta : float ) -> GuardianState:
	return null

func _on_guardian_damaged( hurt_box : HurtBox ) -> void:
	_damage_position = hurt_box.global_position
	state_machine.change_state( self )

func _on_animation_finished(_a: String) -> void:
	_animation_finished = true
