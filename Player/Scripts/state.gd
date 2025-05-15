class_name State extends Node

## store a references to the player that this State belong to
static var player: Player
static var state_machine: PlayerStateMachine

func _ready():
	
	pass


func init() -> void:
	pass

## what happend when the player enter this state?
func Enter() -> void:
	
	
	pass


func Exit() -> void:
	
	pass

## what happen during _process update in this state
func Process( _delta : float ) -> State:
	return null




## what happend during the _pyshics_process update in this state
func Physics( _delta : float ) -> State:
	return null


## what happend with input event in this state
func HandleInput( _event: InputEvent ) -> State:
	return null
