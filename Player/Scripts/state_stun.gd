class_name State_Stun extends State

@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0
@export var invulnarable_duration : float = 1.0

var hurt_box : HurtBox
var direction : Vector2

var next_state : State = null

@onready var idle: State_Idle = $"../Idle"


## what happend when the player enter this state?
func Enter() -> void: 
	
	pass


func Exit() -> void:
	
	pass

## what happen during _process update in this state
func Process( _delta : float ) -> State:
	
	return next_state




## what happend during the _pyshics_process update in this state
func Physics( _delta : float ) -> State:
	return null


## what happend with input event in this state
func HandleInput( _event: InputEvent ) -> State:
	return null
