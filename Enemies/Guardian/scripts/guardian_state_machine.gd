class_name GuardianStateMachine extends Node


var states : Array[ GuardianState ]
var prev_state : GuardianState 
var current_state : GuardianState 

func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	pass

func _process(delta):
	change_state( current_state.process( delta ) )
	pass

func _physics_process(delta):
	change_state( current_state.physics( delta ) )

func initialize( _guardian : Guardian ) -> void:
	states = []
	
	for c in get_children():
		if c is GuardianState:
			states.append( c )
	
	for s in states:
		s.guardian = _guardian
		s.state_machine = self
		s.init()
	
	if states.size() > 0:
		change_state( states[0] )
		process_mode = Node.PROCESS_MODE_INHERIT
	pass

func change_state( new_state : GuardianState ) -> void:
	if new_state == null || new_state == current_state:
		return
	
	if current_state:
		current_state.exit()
	
	
	prev_state = current_state
	current_state = new_state
	current_state.enter()
