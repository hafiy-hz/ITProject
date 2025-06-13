extends Node

const PLAYER = preload("res://Player/Player.tscn")
const INVENTORY_DATA : InventoryData = preload("res://GUI/pause_menu/inventory/player_inventory.tres")

var player : Player
var player_spawn : bool = false
var is_in_game : bool = false  # Flag to track if we're in game or menu

# Layer management
var current_layer: int = 0
var layer_stack: Array[int] = []

signal interact_pressed
signal layer_changed(new_layer: int)
signal player_info_updated

# Add player info for menu/class selection
var player_username: String = ""
var player_class: String = ""
var player_damage: int = 0
var class_damage = {
	"rapier": 7,
	"sword": 10,
	"greatsword": 15
}

func _ready() -> void:
	# Don't spawn player in main menu
	is_in_game = false
	player_spawn = false

func add_player_instance() -> void:
	# Only spawn player if we're in game mode
	if not is_in_game:
		return
		
	player = PLAYER.instantiate()
	add_child(player)
	await get_tree().create_timer(0.2).timeout
	player_spawn = true

func set_health(hp: int, max_hp: int) -> void:
	if player:  # Add null check
		player.max_hp = max_hp
		player.hp = hp
		player.update_hp(0)

func set_player_position(_new_pos: Vector2) -> void:
	if player:  # Add null check
		player.global_position = _new_pos

func set_as_parent(_p: Node2D) -> void:
	if player and player.get_parent():  # Add null check
		player.get_parent().remove_child(player)
	_p.add_child(player)

func unparent_player(_p: Node2D) -> void:
	if player:  # Add null check
		_p.remove_child(player)

# Layer management functions
func push_layer(layer: int) -> void:
	layer_stack.push_back(current_layer)
	current_layer = layer
	layer_changed.emit(current_layer)

func pop_layer() -> void:
	if layer_stack.size() > 0:
		current_layer = layer_stack.pop_back()
		layer_changed.emit(current_layer)

func set_layer(layer: int) -> void:
	current_layer = layer
	layer_stack.clear()
	layer_changed.emit(current_layer)

func get_current_layer() -> int:
	return current_layer

# Function to start the game (call this when leaving main menu)
func start_game() -> void:
	is_in_game = true
	add_player_instance()

# Function to return to menu (call this when going back to main menu)
func return_to_menu() -> void:
	if player:
		player.queue_free()
		player = null
	is_in_game = false
	player_spawn = false
