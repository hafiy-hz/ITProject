class_name State_Walk extends State

@export var move_speed : float = 100.0

@onready var idle: State_Idle = $"../Idle"
@onready var attack: State_Attack = $"../Attack"



## what happend when the player enter this state?
func Enter() -> void: 
	player.UpdateAnimation("walk")
	
	pass


func Exit() -> void:
	
	pass

## what happen during _process update in this state
func Process( _delta : float ) -> State:
	if player.direction == Vector2.ZERO:
		return idle
		
	player.velocity = player.direction * move_speed
	
	if player.SetDirection():
		player.UpdateAnimation("walk")
	
	return null




## what happend during the _pyshics_process update in this state
func Physics( _delta : float ) -> State:
	return null


## what happend with input event in this state
func HandleInput( _event: InputEvent ) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
