class_name EnemyStateMachine extends Node


var states : Array[ EnemyState ]
var prev_state : EnemyState 
var current_state : EnemyState 
var enemy : Enemy
var is_dead: bool = false

func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	pass

func _process(delta):
	change_state( current_state.process( delta ) )
	pass

func _physics_process(delta):
	change_state( current_state.physics( delta ) )

func initialize( _enemy : Enemy ) -> void:
	states = []
	
	for c in get_children():
		if c is EnemyState:
			states.append( c )
	
	for s in states:
		s.enemy = _enemy
		s.state_machine = self
		s.init()
	
	if states.size() > 0:
		change_state( states[0] )
		process_mode = Node.PROCESS_MODE_INHERIT
	pass

func change_state(new_state: EnemyState) -> void:
	if enemy.is_dead:
		return  # 👈 Don't allow any state changes after death

	# Continue with the state change...
	if current_state != null:
		current_state.exit()
	current_state = new_state
	if current_state != null:
		current_state.enter()
