class_name Guardian extends CharacterBody2D

signal direction_changed( new_direction : Vector2 )
signal guardian_damaged( hurt_box : HurtBox )
signal guardian_destroyed( hurt_box : HurtBox )

const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]

@export var hp : int = 100

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var player : Player
var invulnerable : bool = false

@export var summoned_enemy_scene: PackedScene
@export var number_to_summon: int = 3
@export var summon_radius_min: float = 50.0
@export var summon_radius_max: float = 150.0
@export var summon_threshold: int = 50

var has_summoned_on_hp := false


@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var hit_box : HitBox = $HitBox
@onready var state_machine : GuardianStateMachine = $GuardianStateMachine

func _ready():
	randomize()
	state_machine.initialize( self )
	player = PlayerManager.player
	hit_box.damaged.connect( _take_damage )
	pass

func _process(_delta):
	pass

func _physics_process(_delta):
	move_and_slide()

func set_direction( _new_direction : Vector2 ) -> bool:
	direction = _new_direction
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = int( round(
			( direction + cardinal_direction * 0.1 ).angle()
			/ TAU * DIR_4.size()
	))
	var new_dir = DIR_4[ direction_id ]
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	direction_changed.emit( new_dir )
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func update_animation( state : String ) -> void:
	animation_player.play( state + "_" + anim_direction() )
	pass


func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

func _take_damage( hurt_box : HurtBox ) -> void:
	if invulnerable == true:
		return

	hp -= hurt_box.damage
	guardian_damaged.emit()

#summon enemy
	if not has_summoned_on_hp and hp <= summon_threshold:
		_summon_enemies()
		has_summoned_on_hp = true

	# Optional: floating text, death handling, etc.
	if hp == 50:
		_summon_enemies()

	# Show floating damage number
	var floating_text = preload("res://Enemies/floating_text.tscn").instantiate()
	floating_text.position = global_position + Vector2(0, -20)
	floating_text.initial_text = str(hurt_box.damage)
	get_tree().current_scene.add_child(floating_text)

	if hp > 0:
		guardian_damaged.emit( hurt_box )
	else:
		guardian_destroyed.emit( hurt_box )

func _summon_enemies():
	if not summoned_enemy_scene:
		print("No enemy scene assigned.")
		return

	for i in number_to_summon:
		var enemy = summoned_enemy_scene.instantiate()
		if enemy is CharacterBody2D:
			var angle = randf() * TAU
			var radius = randf_range(summon_radius_min, summon_radius_max)
			var offset = Vector2(cos(angle), sin(angle)) * radius

			enemy.global_position = global_position + offset
			get_tree().current_scene.add_child(enemy)
		else:
			print("Warning: Summoned object is not CharacterBody2D.")
