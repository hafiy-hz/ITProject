class_name State_Idle extends State

@onready var walk: State_Walk = $"../Walk"
@onready var attack: State_Attack = $"../Attack"


## what happend when the player enter this state?
func Enter() -> void: 
	player.UpdateAnimation("idle")
	
	pass


func Exit() -> void:
	
	pass

## what happen during _process update in this state
func Process( _delta : float ) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null



## what happend during the _pyshics_process update in this state
func Physics( _delta : float ) -> State:
	return null


## what happend with input event in this state
func HandleInput( _event: InputEvent ) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
