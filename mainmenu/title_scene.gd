extends Node2D

const START_LEVEL : String = "res://stage/level_1.tscn"

@onready var button_start: Button = $CanvasLayer/Control/ButtonStart
@onready var button_exit: Button = $CanvasLayer/Control/ButtonExit

@onready var startbutton: TextureButton = $CanvasLayer/Control/VBoxContainer/Startbutton
@onready var options_button: TextureButton = $CanvasLayer/Control/VBoxContainer/OptionsButton
@onready var exitbutton: TextureButton = $CanvasLayer/Control/VBoxContainer/Exitbutton


	
func _ready() ->void:
	get_tree().paused = true
	PlayerManager.player.visible = false
	
	setup_title_screen()
	
	LevelManagers.level_load_started.connect( exit_title_screen )
	
	
	
	pass

func setup_title_screen() -> void:
	button_start.pressed.connect( start_game )
	button_exit.pressed.connect(exit_game)
	exitbutton.pressed.connect(exit_game)
	
	button_start.grab_focus()
	pass

func start_game() -> void:
	LevelManagers.load_new_level( START_LEVEL, "", Vector2.ZERO )
	pass

func exit_game() -> void:
	get_tree().quit()
	pass

func load_game() -> void:
	SaveManager.load_game()
	pass

func exit_title_screen() -> void:
	PlayerManager.player.visible = true
	
	
	self.queue_free()
 
