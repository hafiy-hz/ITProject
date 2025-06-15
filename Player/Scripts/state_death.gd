class_name State_Death extends State



@export var exhaust_audio : AudioStream
@onready var audio : AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

func _ready():
	
	pass

func init() -> void:
	pass

## what happend when the player enter this state?
func Enter() -> void:
	player.animation_player.play("death")
	audio.stream = exhaust_audio
	audio.play
	PlayerHud.show_game_over_screen(true)
	
	# AudioManager.play_music( null )
	
	pass


func Exit() -> void:
	
	pass

## what happen during _process update in this state
func Process( _delta : float ) -> State:
	player.velocity = Vector2.ZERO
	return null




## what happend during the _pyshics_process update in this state
func Physics( _delta : float ) -> State:
	return null


## what happend with input event in this state
func HandleInput( _event: InputEvent ) -> State:
	return null
